/**
 * Great Docs Termshow Player
 *
 * A lightweight player for pre-rendered SVG terminal recordings.
 * Loads a manifest.json and displays keyframe SVGs with timeline navigation,
 * chapter markers, annotations, and keyboard controls.
 */
(function () {
  'use strict';

  const PLAYER_CLASS = 'gd-termshow';
  const ACTIVE_CLASS = 'gd-tp-active';

  /**
   * Fetch a resource as text or JSON, with file:// fallback via XHR.
   */
  function fetchResource(url, asJson) {
    if (window.location.protocol === 'file:') {
      return new Promise(function (resolve, reject) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onload = function () {
          if (xhr.status === 0 || xhr.status === 200) {
            resolve(asJson ? JSON.parse(xhr.responseText) : xhr.responseText);
          } else {
            reject(new Error('XHR ' + xhr.status));
          }
        };
        xhr.onerror = function () { reject(new Error('XHR network error')); };
        xhr.send();
      });
    }
    return fetch(url).then(function (r) {
      if (!r.ok) throw new Error('HTTP ' + r.status);
      return asJson ? r.json() : r.text();
    });
  }

  /**
   * Initialize all termshow player instances on the page.
   */
  function initAll() {
    const players = document.querySelectorAll(`.${PLAYER_CLASS}`);
    players.forEach((el) => initPlayer(el));
  }

  /**
   * Initialize a single termshow player instance.
   */
  function initPlayer(container) {
    const manifestUrl = container.dataset.manifest;
    if (!manifestUrl) return;

    // Prevent double-init
    if (container.classList.contains(ACTIVE_CLASS)) return;
    container.classList.add(ACTIVE_CLASS);

    const options = {
      autoplay: container.dataset.autoplay === 'true',
      speed: parseFloat(container.dataset.speed) || 1.0,
      pauseOnChapters: container.dataset.pauseOnChapters === 'true',
      loop: container.dataset.loop === 'true',
    };

    // Create player state
    const state = {
      manifest: null,
      frames: null,
      currentTime: 0,
      playing: false,
      ended: false,
      chapterPaused: false,
      currentKeyframeIdx: -1,
      animFrameId: null,
      lastTick: null,
      speed: options.speed,
      baseUrl: manifestUrl.substring(0, manifestUrl.lastIndexOf('/') + 1),
    };

    // Try to read inline manifest + frames (embedded by Lua filter)
    var inlineManifest = null;
    var inlineFrames = null;
    var manifestEl = container.querySelector('script.gd-tp-manifest');
    var framesEl = container.querySelector('script.gd-tp-frames');
    if (manifestEl) {
      try { inlineManifest = JSON.parse(manifestEl.textContent); } catch (e) {}
    }
    if (framesEl) {
      try { inlineFrames = JSON.parse(framesEl.textContent); } catch (e) {}
    }

    // Title bar (separate from viewport, above it)
    const chapterBar = document.createElement('div');
    chapterBar.className = 'gd-tp-chapter-bar';

    // Build player DOM
    const viewport = document.createElement('div');
    viewport.className = 'gd-tp-viewport';
    // Defer tabindex until user interaction to prevent Safari from treating
    // auto-playing players as scroll-restoration targets.
    if (!options.autoplay) {
      viewport.setAttribute('tabindex', '0');
    }
    viewport.setAttribute('role', 'application');
    viewport.setAttribute('aria-label', 'Terminal recording player');

    const svgContainer = document.createElement('div');
    svgContainer.className = 'gd-tp-svg';
    viewport.appendChild(svgContainer);

    const highlightLayer = document.createElement('div');
    highlightLayer.className = 'gd-tp-highlights';
    viewport.appendChild(highlightLayer);
    state.highlightLayer = highlightLayer;

    const annotationLayer = document.createElement('div');
    annotationLayer.className = 'gd-tp-annotations';
    viewport.appendChild(annotationLayer);

    // Copy-snippet buttons (placed in chapter/title bar)
    const snippetLayer = document.createElement('div');
    snippetLayer.className = 'gd-tp-snippets';
    chapterBar.appendChild(snippetLayer);
    state.snippetLayer = snippetLayer;

    // Center overlay (play / replay)
    const centerOverlay = document.createElement('div');
    centerOverlay.className = 'gd-tp-center-overlay';
    centerOverlay.setAttribute('aria-hidden', 'true');
    const centerBtn = document.createElement('div');
    centerBtn.className = 'gd-tp-center-overlay-btn';
    centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
    centerOverlay.appendChild(centerBtn);
    viewport.appendChild(centerOverlay);

    const controls = buildControls();

    // Replace container content with player structure
    container.innerHTML = '';
    container.appendChild(chapterBar);
    container.appendChild(viewport);
    container.appendChild(controls.root);

    // Initialize with manifest (inline or fetched)
    function activate(manifest, frames) {
      state.manifest = manifest;
      state.frames = frames;
      controls.duration.textContent = formatTime(manifest.duration);
      renderChapterMarkers(controls.timeline, manifest);

      // Add traffic light decorations if window_chrome is set
      var chrome = manifest.window_chrome || 'none';
      var hasChapters = manifest.chapters && manifest.chapters.length > 0;
      var hasSnippets = manifest.snippets && manifest.snippets.length > 0;
      if (chrome === 'none' && !hasChapters && !hasSnippets) {
        chapterBar.style.display = 'none';
      } else if (chrome !== 'none') {
        chapterBar.classList.add('gd-tp-has-chrome');
        var lights = document.createElement('div');
        lights.className = 'gd-tp-traffic-lights' + (chrome === 'minimal' ? ' gd-tp-chrome-minimal' : '');
        lights.innerHTML = '<span class="gd-tp-traffic-dot gd-tp-dot-close"></span>' +
          '<span class="gd-tp-traffic-dot gd-tp-dot-minimize"></span>' +
          '<span class="gd-tp-traffic-dot gd-tp-dot-maximize"></span>';
        chapterBar.appendChild(lights);
      }

      // Add a span for chapter text (so traffic lights aren't overwritten)
      var chapterText = document.createElement('span');
      chapterText.className = 'gd-tp-chapter-text';
      chapterBar.appendChild(chapterText);
      state.chapterText = chapterText;

      updateChapterBar(chapterBar, manifest, 0);
      // Show initial frame
      showFrame(state, svgContainer, 0);
      if (options.autoplay) {
        play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
      }
    }

    if (inlineManifest) {
      // Always try fetching the external manifest first (it reflects the latest
      // termshow render without requiring an HTML rebuild). Fall back to inline
      // data if the fetch fails (file:// protocol, offline, etc.).
      fetchResource(manifestUrl, true)
        .then(function (manifest) { activate(manifest, null); })
        .catch(function () { activate(inlineManifest, inlineFrames); });
    } else {
      // No inline data: fetch is the only option
      fetchResource(manifestUrl, true)
        .then(function (manifest) { activate(manifest, null); })
        .catch(function (err) {
          console.warn('[termshow] Failed to load manifest:', manifestUrl, err);
        });
    }

    // Restore tabindex on first user interaction (for keyboard nav)
    function ensureTabindex() {
      if (!viewport.hasAttribute('tabindex')) {
        viewport.setAttribute('tabindex', '0');
      }
    }

    // Event listeners
    controls.playBtn.addEventListener('click', () => {
      ensureTabindex();
      if (state.playing) {
        pause(state, controls, container, centerOverlay);
      } else if (state.ended) {
        // Return to initial state (don't autoplay)
        state.ended = false;
        state.currentTime = 0;
        state.currentKeyframeIdx = -1;
        controls.playBtn.textContent = '\u25b6';
        controls.playBtn.setAttribute('aria-label', 'Play');
        centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
        container.classList.remove('gd-tp-ended');
        updateDisplay(state, svgContainer, annotationLayer, controls);
        updateChapterBar(chapterBar, state.manifest, state.currentTime);
      } else {
        play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
      }
    });

    centerOverlay.addEventListener('click', () => {
      ensureTabindex();
      if (state.ended) {
        // Return to initial state (don't autoplay)
        state.ended = false;
        state.currentTime = 0;
        state.currentKeyframeIdx = -1;
        controls.playBtn.textContent = '\u25b6';
        controls.playBtn.setAttribute('aria-label', 'Play');
        centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
        container.classList.remove('gd-tp-ended');
        updateDisplay(state, svgContainer, annotationLayer, controls);
        updateChapterBar(chapterBar, state.manifest, state.currentTime);
        return;
      }
      play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
    });

    // Double-click/tap on viewport: left 30% rewinds 5s, right 30% fast-forwards 5s
    // Uses pointerdown for immediate, reliable detection unaffected by overlay state
    var vpTapTime = 0;
    var vpTapX = 0;

    function handleViewportSeek(clientX) {
      if (!state.manifest) return;
      var rect = viewport.getBoundingClientRect();
      var x = clientX - rect.left;
      var w = rect.width;
      var newTime;
      if (x < w * 0.3) {
        newTime = Math.max(0, state.currentTime - 5);
      } else if (x > w * 0.7) {
        newTime = Math.min(state.manifest.duration, state.currentTime + 5);
      } else {
        return; // Middle 40% — no action
      }
      if (state.ended) {
        state.ended = false;
        controls.playBtn.textContent = '\u25b6';
        controls.playBtn.setAttribute('aria-label', 'Play');
        centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
        container.classList.remove('gd-tp-ended');
      }
      seek(state, newTime, svgContainer, annotationLayer, controls);
      updateChapterBar(chapterBar, state.manifest, state.currentTime);
    }

    viewport.addEventListener('pointerdown', (e) => {
      if (!state.manifest) return;
      if (e.target.closest('.gd-tp-controls')) return;
      if (!state.playing && !state.ended) return; // Let center overlay handle paused state
      var now = Date.now();
      var dx = Math.abs(e.clientX - vpTapX);
      if (now - vpTapTime < 400 && dx < 50) {
        vpTapTime = 0;
        handleViewportSeek(e.clientX);
      } else {
        vpTapTime = now;
        vpTapX = e.clientX;
      }
    });

    controls.timeline.addEventListener('mousedown', (e) => {
      if (!state.manifest) return;
      // If the click landed on a chapter marker, snap to it instead of starting drag
      var markerEl = e.target.closest('.gd-tp-chapter-marker');
      if (markerEl) {
        var chapterTime = parseFloat(markerEl.dataset.time);
        if (!isNaN(chapterTime)) {
          if (state.ended) {
            state.ended = false;
            controls.playBtn.textContent = '\u25b6';
            controls.playBtn.setAttribute('aria-label', 'Play');
            centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
            container.classList.remove('gd-tp-ended');
          }
          state.chapterPaused = false;
          container.classList.remove('gd-tp-chapter-paused');
          seek(state, chapterTime, svgContainer, annotationLayer, controls);
          updateChapterBar(chapterBar, state.manifest, state.currentTime);
        }
        return;
      }
      e.preventDefault();
      var wasPlaying = state.playing;
      if (state.playing) {
        pause(state, controls, container, centerOverlay);
      }
      controls.timeline.classList.add('gd-tp-dragging');
      // Reset ended/chapter-paused state
      if (state.ended) {
        state.ended = false;
        controls.playBtn.textContent = '\u25b6';
        controls.playBtn.setAttribute('aria-label', 'Play');
        centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
        container.classList.remove('gd-tp-ended');
      }
      state.chapterPaused = false;
      container.classList.remove('gd-tp-chapter-paused');

      function seekFromEvent(ev) {
        var rect = controls.timeline.getBoundingClientRect();
        var ratio = Math.max(0, Math.min(1, (ev.clientX - rect.left) / rect.width));
        seek(state, ratio * state.manifest.duration, svgContainer, annotationLayer, controls);
        updateChapterBar(chapterBar, state.manifest, state.currentTime);
      }

      seekFromEvent(e);

      function onMove(ev) {
        ev.preventDefault();
        seekFromEvent(ev);
      }

      function onUp() {
        controls.timeline.classList.remove('gd-tp-dragging');
        document.removeEventListener('mousemove', onMove);
        document.removeEventListener('mouseup', onUp);
        if (wasPlaying) {
          play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
        }
      }

      document.addEventListener('mousemove', onMove);
      document.addEventListener('mouseup', onUp);
    });

    // Touch support for timeline drag
    controls.timeline.addEventListener('touchstart', (e) => {
      if (!state.manifest) return;
      e.preventDefault();
      var wasPlaying = state.playing;
      if (state.playing) {
        pause(state, controls, container, centerOverlay);
      }
      controls.timeline.classList.add('gd-tp-dragging');
      if (state.ended) {
        state.ended = false;
        controls.playBtn.textContent = '\u25b6';
        controls.playBtn.setAttribute('aria-label', 'Play');
        centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
        container.classList.remove('gd-tp-ended');
      }
      state.chapterPaused = false;
      container.classList.remove('gd-tp-chapter-paused');

      function seekFromTouch(ev) {
        var touch = ev.touches[0] || ev.changedTouches[0];
        var rect = controls.timeline.getBoundingClientRect();
        var ratio = Math.max(0, Math.min(1, (touch.clientX - rect.left) / rect.width));
        seek(state, ratio * state.manifest.duration, svgContainer, annotationLayer, controls);
        updateChapterBar(chapterBar, state.manifest, state.currentTime);
      }

      seekFromTouch(e);

      function onTouchMove(ev) {
        ev.preventDefault();
        seekFromTouch(ev);
      }

      function onTouchEnd() {
        controls.timeline.classList.remove('gd-tp-dragging');
        document.removeEventListener('touchmove', onTouchMove);
        document.removeEventListener('touchend', onTouchEnd);
        if (wasPlaying) {
          play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
        }
      }

      document.addEventListener('touchmove', onTouchMove, { passive: false });
      document.addEventListener('touchend', onTouchEnd);
    }, { passive: false });

    // Speed control
    controls.speedBtn.addEventListener('click', () => {
      const speeds = [0.5, 1, 1.5, 2, 3];
      const idx = speeds.indexOf(state.speed);
      state.speed = speeds[(idx + 1) % speeds.length];
      controls.speedBtn.textContent = state.speed + '\u00d7';
    });

    // Keyboard navigation
    viewport.addEventListener('keydown', (e) => {
      if (!state.manifest) return;

      switch (e.key) {
        case ' ':
          e.preventDefault();
          if (state.playing) pause(state, controls, container, centerOverlay);
          else if (state.ended) {
            state.ended = false;
            state.currentTime = 0;
            state.currentKeyframeIdx = -1;
            controls.playBtn.textContent = '\u25b6';
            controls.playBtn.setAttribute('aria-label', 'Play');
            centerBtn.innerHTML = '<span class="gd-tp-icon-play">\u25b6</span>';
            container.classList.remove('gd-tp-ended');
            updateDisplay(state, svgContainer, annotationLayer, controls);
            updateChapterBar(chapterBar, state.manifest, state.currentTime);
          } else {
            play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar);
          }
          break;
        case 'ArrowRight':
          e.preventDefault();
          seek(state, state.currentTime + 5, svgContainer, annotationLayer, controls);
          break;
        case 'ArrowLeft':
          e.preventDefault();
          seek(state, state.currentTime - 5, svgContainer, annotationLayer, controls);
          break;
        case '.':
          e.preventDefault();
          nextChapter(state, svgContainer, annotationLayer, controls);
          break;
        case ',':
          e.preventDefault();
          prevChapter(state, svgContainer, annotationLayer, controls);
          break;
      }
    });
  }

  // --- Playback ---

  function play(state, svgContainer, annotationLayer, controls, options, container, centerOverlay, chapterBar) {
    state.playing = true;
    state.ended = false;
    state.chapterPaused = false;
    state.lastTick = performance.now();
    controls.playBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" stroke="none"><rect x="6" y="4" width="4" height="16" rx="1"/><rect x="14" y="4" width="4" height="16" rx="1"/></svg>';
    controls.playBtn.setAttribute('aria-label', 'Pause');
    container.classList.add('gd-tp-playing');
    container.classList.remove('gd-tp-ended');
    container.classList.remove('gd-tp-chapter-paused');

    function tick(now) {
      if (!state.playing) return;

      const dt = ((now - state.lastTick) / 1000) * state.speed;
      state.lastTick = now;
      state.currentTime += dt;

      const manifest = state.manifest;
      if (state.currentTime >= manifest.duration) {
        if (options.loop) {
          state.currentTime = 0;
        } else {
          state.currentTime = manifest.duration;
          state.ended = true;
          pause(state, controls, container, centerOverlay);
          // Show replay icon in controls and overlay
          controls.playBtn.textContent = '\u21ba'; // ↺
          controls.playBtn.setAttribute('aria-label', 'Replay');
          centerOverlay.querySelector('.gd-tp-center-overlay-btn').innerHTML =
            '<span>\u21ba</span>';
          container.classList.remove('gd-tp-playing');
          container.classList.add('gd-tp-ended');
          return;
        }
      }

      // Check chapter pause
      if (options.pauseOnChapters && manifest.chapters.length > 0) {
        const prevTime = state.currentTime - dt;
        for (const ch of manifest.chapters) {
          if (ch.time > 0 && prevTime < ch.time && state.currentTime >= ch.time) {
            state.currentTime = ch.time;
            state.chapterPaused = true;
            pause(state, controls, container, centerOverlay);
            updateDisplay(state, svgContainer, annotationLayer, controls);
            updateChapterBar(chapterBar, manifest, state.currentTime);
            return;
          }
        }
      }

      updateDisplay(state, svgContainer, annotationLayer, controls);
      updateChapterBar(chapterBar, manifest, state.currentTime);
      state.animFrameId = requestAnimationFrame(tick);
    }

    state.animFrameId = requestAnimationFrame(tick);
  }

  function pause(state, controls, container, centerOverlay) {
    state.playing = false;
    if (state.animFrameId) {
      cancelAnimationFrame(state.animFrameId);
      state.animFrameId = null;
    }
    if (!state.ended) {
      controls.playBtn.textContent = '\u25b6'; // ▶
      controls.playBtn.setAttribute('aria-label', 'Play');
    }
    if (container) {
      container.classList.remove('gd-tp-playing');
      // Hide center overlay on chapter pauses (only show at start/end)
      if (state.chapterPaused) {
        container.classList.add('gd-tp-chapter-paused');
      } else {
        container.classList.remove('gd-tp-chapter-paused');
      }
    }
  }

  function seek(state, time, svgContainer, annotationLayer, controls) {
    state.currentTime = Math.max(0, Math.min(time, state.manifest.duration));
    updateDisplay(state, svgContainer, annotationLayer, controls);
  }

  function nextChapter(state, svgContainer, annotationLayer, controls) {
    if (!state.manifest || !state.manifest.chapters.length) return;
    for (const ch of state.manifest.chapters) {
      if (ch.time > state.currentTime + 0.1) {
        seek(state, ch.time, svgContainer, annotationLayer, controls);
        return;
      }
    }
  }

  function prevChapter(state, svgContainer, annotationLayer, controls) {
    if (!state.manifest || !state.manifest.chapters.length) return;
    const chapters = state.manifest.chapters;
    for (let i = chapters.length - 1; i >= 0; i--) {
      if (chapters[i].time < state.currentTime - 0.5) {
        seek(state, chapters[i].time, svgContainer, annotationLayer, controls);
        return;
      }
    }
    seek(state, 0, svgContainer, annotationLayer, controls);
  }

  // --- Display ---

  function updateDisplay(state, svgContainer, annotationLayer, controls) {
    const manifest = state.manifest;
    if (!manifest) return;

    // Update timeline progress
    const progress = manifest.duration > 0 ? state.currentTime / manifest.duration : 0;
    controls.progress.style.width = (progress * 100) + '%';
    controls.time.textContent = formatTime(state.currentTime);
    controls.duration.textContent = formatTime(manifest.duration - state.currentTime);

    // Find the correct keyframe for current time
    const kfIdx = findKeyframeIndex(manifest.keyframes, state.currentTime);
    if (kfIdx !== state.currentKeyframeIdx) {
      state.currentKeyframeIdx = kfIdx;
      showFrame(state, svgContainer, kfIdx);
    }

    // Update annotations
    updateAnnotations(annotationLayer, manifest.annotations, state.currentTime);

    // Update highlights
    if (state.highlightLayer) {
      updateHighlights(state.highlightLayer, manifest.highlights, state.currentTime, svgContainer);
    }

    // Update copy-snippet buttons
    updateSnippets(state.snippetLayer, manifest.snippets, state.currentTime, svgContainer);
  }

  function updateChapterBar(chapterBar, manifest, time) {
    var textEl = chapterBar.querySelector('.gd-tp-chapter-text');
    if (!textEl) return;
    if (!manifest || !manifest.chapters || manifest.chapters.length === 0) {
      textEl.textContent = '';
      return;
    }
    // Find the current chapter (last one at or before current time)
    var label = '';
    for (let i = manifest.chapters.length - 1; i >= 0; i--) {
      if (manifest.chapters[i].time <= time + 0.05) {
        label = manifest.chapters[i].label || '';
        break;
      }
    }
    textEl.textContent = label;
  }

  function showFrame(state, svgContainer, idx) {
    const manifest = state.manifest;
    if (!manifest || idx < 0 || idx >= manifest.keyframes.length) return;

    // Pin height before replacing innerHTML to prevent layout collapse.
    // All frames in a recording share the same dimensions, so we pin once
    // and keep it for the lifetime of playback. This prevents Safari's
    // scroll-preservation heuristic from firing on the last player where
    // even a sub-frame height flicker affects scrollHeight.
    if (!svgContainer.style.minHeight) {
      var pinHeight = svgContainer.offsetHeight;
      if (pinHeight > 0) {
        svgContainer.style.minHeight = pinHeight + 'px';
      }
    }

    // Use inline frames if available (no fetch needed)
    if (state.frames && state.frames[idx]) {
      svgContainer.innerHTML = state.frames[idx];
      return;
    }

    // Fallback: fetch the SVG file
    const kf = manifest.keyframes[idx];
    const svgUrl = state.baseUrl + kf.file;

    fetchResource(svgUrl, false)
      .then((svg) => {
        svgContainer.innerHTML = svg;
      })
      .catch(() => {});
  }

  function findKeyframeIndex(keyframes, time) {
    // Find the last keyframe at or before the current time
    let idx = 0;
    for (let i = keyframes.length - 1; i >= 0; i--) {
      if (keyframes[i].time <= time) {
        idx = i;
        break;
      }
    }
    return idx;
  }

  function updateAnnotations(layer, annotations, time) {
    if (!annotations || annotations.length === 0) {
      for (var i = 0; i < layer.children.length; i++) {
        layer.children[i].style.opacity = '0';
      }
      return;
    }

    // Pre-create elements with full styling at init time. Once created, ONLY
    // opacity is mutated per-frame. This prevents Safari from re-evaluating
    // position styles (top/bottom/margin-block) during playback, which triggers
    // its scroll-position recalculation bug.
    if (!layer._annEls) {
      layer._annEls = [];
      for (var j = 0; j < annotations.length; j++) {
        var ann0 = annotations[j];
        var el = document.createElement('div');
        var wCls = ann0.width && ann0.width !== 'medium' ? ' gd-tp-ann-w-' + ann0.width : '';
        el.className = 'gd-tp-annotation gd-tp-ann-' + ann0.position + ' gd-tp-ann-' + ann0.style + wCls;
        el.textContent = ann0.text;
        el.style.opacity = '0';
        el.setAttribute('aria-hidden', 'true');
        layer.appendChild(el);
        layer._annEls.push(el);
      }
    }

    for (var k = 0; k < annotations.length; k++) {
      var ann = annotations[k];
      var node = layer._annEls[k];
      if (time >= ann.time && time <= ann.time + ann.duration) {
        // Fade progress (for smooth entry/exit)
        var elapsed = time - ann.time;
        var fadeIn = Math.min(1, elapsed / 0.3);
        var fadeOut = Math.min(1, (ann.duration - elapsed) / 0.3);
        node.style.opacity = Math.min(fadeIn, fadeOut);
      } else {
        if (node.style.opacity !== '0') node.style.opacity = '0';
      }
    }
  }

  function updateHighlights(layer, highlights, time, svgContainer) {
    if (!highlights || highlights.length === 0) {
      if (layer._hlEls) {
        for (var i = 0; i < layer._hlEls.length; i++) {
          layer._hlEls[i].style.opacity = '0';
        }
      }
      return;
    }

    // Pre-create highlight elements once
    if (!layer._hlEls) {
      layer._hlEls = [];
      for (var j = 0; j < highlights.length; j++) {
        var hl = highlights[j];
        var el = document.createElement('div');
        el.className = 'gd-tp-highlight gd-tp-hl-' + hl.style;
        el.style.cssText = 'position:absolute;pointer-events:none;opacity:0;';
        if (hl.color) {
          el.style.setProperty('--hl-color', hl.color);
        }
        if (hl.pulse) {
          el.classList.add('gd-tp-hl-pulse');
        }
        // Badge content
        if ((hl.style === 'badge-before' || hl.style === 'badge-after') && (hl.badge_text || hl.badge_icon)) {
          var badge = document.createElement('span');
          badge.className = 'gd-tp-hl-badge';
          badge.textContent = (hl.badge_icon || '') + (hl.badge_text || '');
          el.appendChild(badge);
        }
        el.setAttribute('aria-hidden', 'true');
        layer.appendChild(el);
        layer._hlEls.push(el);
      }
    }

    // Measure grid in viewBox coordinates (cacheable — never changes with resize)
    var grid = layer._grid;
    if (!grid) {
      grid = measureViewBoxGrid(svgContainer);
      if (grid) layer._grid = grid;
    }

    for (var k = 0; k < highlights.length; k++) {
      var h = highlights[k];
      var node = layer._hlEls[k];
      if (time >= h.time && time <= h.time + h.duration) {
        var elapsed = time - h.time;
        var fadeInDur = h.fade_in != null ? h.fade_in : 0.3;
        var fadeOutDur = h.fade_out != null ? h.fade_out : 0.3;
        var fadeIn = fadeInDur > 0 ? Math.min(1, elapsed / fadeInDur) : 1;
        var fadeOut = fadeOutDur > 0 ? Math.min(1, (h.duration - elapsed) / fadeOutDur) : 1;
        node.style.opacity = Math.min(fadeIn, fadeOut);

        // Position using percentage of viewBox (scales with SVG responsively)
        if (grid && h.target && h.target.region) {
          var r = h.target.region;
          var x = grid.translateX + r.col * grid.cellW;
          var y = grid.translateY + r.row * grid.cellH;
          var w = r.width * grid.cellW;
          var hh = r.height * grid.cellH;
          node.style.left = (x / grid.vbW * 100) + '%';
          node.style.top = (y / grid.vbH * 100) + '%';
          node.style.width = (w / grid.vbW * 100) + '%';
          node.style.height = (hh / grid.vbH * 100) + '%';
        } else if (grid && h.target && h.target.lines) {
          var lines = h.target.lines;
          var minLine = Math.min.apply(null, lines);
          var maxLine = Math.max.apply(null, lines);
          var ly = grid.translateY + minLine * grid.cellH;
          var lh = (maxLine - minLine + 1) * grid.cellH;
          node.style.left = '0%';
          node.style.top = (ly / grid.vbH * 100) + '%';
          node.style.width = '100%';
          node.style.height = (lh / grid.vbH * 100) + '%';
        }
      } else {
        if (node.style.opacity !== '0') node.style.opacity = '0';
      }
    }
  }

  /**
   * Measure character grid in viewBox coordinates (SVG units).
   * Returns {vbW, vbH, cellW, cellH, translateX, translateY} or null.
   * These values are resolution-independent and never change with browser width.
   */
  function measureViewBoxGrid(svgContainer) {
    var svg = svgContainer.querySelector('svg');
    if (!svg) return null;

    // Get viewBox dimensions
    var viewBox = svg.getAttribute('viewBox');
    if (!viewBox) return null;
    var parts = viewBox.split(/\s+|,/);
    var vbW = parseFloat(parts[2]);
    var vbH = parseFloat(parts[3]);
    if (!vbW || !vbH) return null;

    // Find the <g transform="translate(...)"> that wraps text content
    var g = svg.querySelector('g[transform]');
    var translateX = 0, translateY = 0;
    if (g) {
      var m = g.getAttribute('transform').match(/translate\(\s*([\d.]+)\s*[,\s]\s*([\d.]+)\s*\)/);
      if (m) {
        translateX = parseFloat(m[1]);
        translateY = parseFloat(m[2]);
      }
    }

    // Determine cell size from cursor rect or text elements (in SVG units)
    var cursor = svg.querySelector('rect.gd-tp-cursor');
    var cellW, cellH;
    if (cursor) {
      cellW = parseFloat(cursor.getAttribute('width')) || 8.4;
      cellH = parseFloat(cursor.getAttribute('height')) || 21;
    } else {
      var textEls = svg.querySelectorAll('.gd-tp-text');
      if (textEls.length < 2) return null;
      var ys = [], xs = [];
      for (var i = 0; i < Math.min(textEls.length, 50); i++) {
        var y = parseFloat(textEls[i].getAttribute('y'));
        var x = parseFloat(textEls[i].getAttribute('x'));
        if (!isNaN(y) && ys.indexOf(y) < 0) ys.push(y);
        if (!isNaN(x) && xs.indexOf(x) < 0) xs.push(x);
      }
      ys.sort(function(a, b) { return a - b; });
      xs.sort(function(a, b) { return a - b; });
      cellH = ys.length >= 2 ? ys[1] - ys[0] : 21;
      cellW = xs.length >= 2 ? xs[1] - xs[0] : 8.4;
    }

    return {
      vbW: vbW,
      vbH: vbH,
      cellW: cellW,
      cellH: cellH,
      translateX: translateX,
      translateY: translateY
    };
  }

  function updateSnippets(layer, snippets, time, svgContainer) {
    if (!snippets || snippets.length === 0) {
      if (layer._cmdEls) {
        for (var i = 0; i < layer._cmdEls.length; i++) {
          layer._cmdEls[i].style.display = 'none';
          layer._cmdEls[i].style.opacity = '0';
        }
      }
      return;
    }

    // Pre-create snippet copy buttons at init time
    if (!layer._cmdEls) {
      layer._cmdEls = [];
      for (var j = 0; j < snippets.length; j++) {
        var snip = snippets[j];
        var el = document.createElement('button');
        el.className = 'gd-tp-copy-snippet';
        el.setAttribute('type', 'button');
        el.setAttribute('aria-label', 'Copy snippet: ' + (snip.text || snip.match));
        el.dataset.text = snip.text;
        el.dataset.match = snip.match || '';
        el.innerHTML = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>' +
          '<span class="gd-tp-copy-label">' + (snip.label || 'Copy') + '</span>';
        el.style.display = 'none';
        el.addEventListener('click', (function(btn, idx) {
          return function(e) {
            e.stopPropagation();
            var copyText = resolveSnippetText(snippets[idx], svgContainer);
            if (copyText) {
              navigator.clipboard.writeText(copyText).then(function() {
                btn.classList.add('gd-tp-copied');
                setTimeout(function() { btn.classList.remove('gd-tp-copied'); }, 1500);
              });
            }
          };
        })(el, j));
        layer.appendChild(el);
        layer._cmdEls.push(el);
      }
    }

    // Show only one snippet at a time (first active wins; overlaps are clipped)
    var activeIdx = -1;
    for (var k = 0; k < snippets.length; k++) {
      var c = snippets[k];
      if (activeIdx < 0 && time >= c.time && time <= c.time + c.duration) {
        activeIdx = k;
        var elapsed = time - c.time;
        var fadeIn = Math.min(1, elapsed / 0.3);
        var fadeOut = Math.min(1, (c.duration - elapsed) / 0.3);
        layer._cmdEls[k].style.display = 'inline-flex';
        layer._cmdEls[k].style.opacity = Math.min(fadeIn, fadeOut);
      } else {
        layer._cmdEls[k].style.display = 'none';
        layer._cmdEls[k].style.opacity = '0';
      }
    }
  }

  /**
   * Resolve the text to copy for a snippet.
   * If `match` is set, extract text from the SVG and run the regex.
   * If regex has a capture group, use group(1); otherwise use group(0).
   * Falls back to literal `text` field.
   */
  function resolveSnippetText(snip, svgContainer) {
    if (snip.match) {
      var buffer = extractSvgText(svgContainer);
      try {
        var re = new RegExp(snip.match);
        var m = re.exec(buffer);
        if (m) return m[1] !== undefined ? m[1] : m[0];
      } catch (e) { /* invalid regex — fall through */ }
    }
    return snip.text || '';
  }

  /**
   * Extract the plain-text content of the current SVG frame.
   * Groups <text> elements by y-coordinate to reconstruct terminal lines.
   */
  function extractSvgText(svgContainer) {
    var svg = svgContainer.querySelector('svg');
    if (!svg) return '';
    var textEls = svg.querySelectorAll('.gd-tp-text');
    if (!textEls.length) return '';
    // Group by y-coordinate (row)
    var rows = {};
    for (var i = 0; i < textEls.length; i++) {
      var el = textEls[i];
      var y = parseFloat(el.getAttribute('y')) || 0;
      var x = parseFloat(el.getAttribute('x')) || 0;
      var key = Math.round(y * 10); // quantize y to avoid float drift
      if (!rows[key]) rows[key] = [];
      rows[key].push({ x: x, text: el.textContent || '' });
    }
    // Sort rows by y, spans within rows by x
    var keys = Object.keys(rows).map(Number).sort(function(a, b) { return a - b; });
    var lines = [];
    for (var k = 0; k < keys.length; k++) {
      var spans = rows[keys[k]].sort(function(a, b) { return a.x - b.x; });
      var line = '';
      for (var s = 0; s < spans.length; s++) line += spans[s].text;
      lines.push(line);
    }
    return lines.join('\n');
  }

  // --- Controls UI ---

  function buildControls() {
    const root = document.createElement('div');
    root.className = 'gd-tp-controls';

    const playBtn = document.createElement('button');
    playBtn.className = 'gd-tp-play-btn';
    playBtn.textContent = '\u25b6'; // ▶
    playBtn.setAttribute('aria-label', 'Play');

    const time = document.createElement('span');
    time.className = 'gd-tp-time';
    time.textContent = '0:00';

    const timeline = document.createElement('div');
    timeline.className = 'gd-tp-timeline';
    timeline.setAttribute('role', 'slider');
    timeline.setAttribute('aria-label', 'Playback position');

    const progress = document.createElement('div');
    progress.className = 'gd-tp-progress';
    timeline.appendChild(progress);

    const duration = document.createElement('span');
    duration.className = 'gd-tp-duration';
    duration.textContent = '0:00';

    const speedBtn = document.createElement('button');
    speedBtn.className = 'gd-tp-speed-btn';
    speedBtn.textContent = '1\u00d7';
    speedBtn.setAttribute('aria-label', 'Playback speed');

    root.appendChild(playBtn);
    root.appendChild(time);
    root.appendChild(timeline);
    root.appendChild(duration);
    root.appendChild(speedBtn);

    return { root, playBtn, time, timeline, progress, duration, speedBtn };
  }

  function renderChapterMarkers(timeline, manifest) {
    if (!manifest.chapters || manifest.chapters.length === 0) return;

    for (const ch of manifest.chapters) {
      if (ch.time > manifest.duration) continue;
      const pct = manifest.duration > 0 ? (ch.time / manifest.duration) * 100 : 0;
      const marker = document.createElement('div');
      marker.className = 'gd-tp-chapter-marker';
      marker.style.left = pct + '%';
      marker.setAttribute('title', ch.label || 'Chapter');
      marker.dataset.time = ch.time;
      timeline.appendChild(marker);
    }
  }

  // --- Utilities ---

  function formatTime(seconds) {
    const m = Math.floor(seconds / 60);
    const s = Math.floor(seconds % 60);
    return m + ':' + (s < 10 ? '0' : '') + s;
  }

  // --- Initialization ---

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAll);
  } else {
    initAll();
  }

  // Also handle Quarto's dynamic content loading
  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      for (const node of mutation.addedNodes) {
        if (node.nodeType === 1) {
          if (node.classList && node.classList.contains(PLAYER_CLASS)) {
            initPlayer(node);
          }
          const nested = node.querySelectorAll && node.querySelectorAll(`.${PLAYER_CLASS}`);
          if (nested) nested.forEach((el) => initPlayer(el));
        }
      }
    }
  });
  observer.observe(document.body, { childList: true, subtree: true });
})();
