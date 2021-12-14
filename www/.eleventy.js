const yaml = require("js-yaml");
const fs   = require('fs');
const { DateTime } = require("luxon");
const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const path = require("path");
const Image = require("@11ty/eleventy-img");
const nunjucks = require("nunjucks");
var sprintf = require('sprintf-js').sprintf
const readingTime = require('eleventy-plugin-reading-time');

async function imgShortcode(src, alt, widths, classes, lazy = true) {
  src = "src/img/" + src
  let metadata = await Image(src, {
    widths: widths,
    formats: ["webp", "jpg"],
    urlPath: "/img/",
    outputDir: "./_site/img/",
    sharpWebpOptions: {"quality": 80},
    sharpJpegOptions: {"quality": 80,
                       "progressive": true,
                       "trellisQuantisation": true,
                       "overshootDeringing": true,
                       "optimiseScans": true,
                       "quantisationTable": 3},
    filenameFormat: function (id, src, width, format, options) {
      const extension = path.extname(src);
      const name = path.basename(src, extension);
      return `${name}.${width}w.${format}`;
    }
  });

  let lowsrc = metadata.jpeg[0];

  let loading = lazy ? "lazy" : "eager";

  return `<picture>
    ${Object.values(metadata).map(imageFormat => {
      return `  <source type="${imageFormat[0].sourceType}" sizes="100vw" srcset="${imageFormat.map(entry => entry.srcset).join(", ")}" media="(min-width: 0px)">`;
    }).join("\n")}

      <img class="${classes}" src="${lowsrc.url}" alt="${alt}" loading="${loading}">
    </picture>`;
}

async function imageShortcode(src, alt) {
  src = "src/photos/" + src
  let metadata = await Image(src, {
    widths: [800, 1200, 1600, 2000, 2400],
    formats: ["webp", "jpg"],
    urlPath: "/img/photos/",
    outputDir: "./_site/img/photos",
    sharpWebpOptions: {"quality": 90},
    sharpJpegOptions: {"quality": 90,
                       "progressive": true,
                       "trellisQuantisation": true,
                       "overshootDeringing": true,
                       "optimiseScans": true,
                       "quantisationTable": 3},
    filenameFormat: function (id, src, width, format, options) {
      const extension = path.extname(src);
      const name = path.basename(src, extension);
      return `${name}.${width}w.${format}`;
    }
  });

  let lowsrc = metadata.jpeg[0];

  return `<picture>
    ${Object.values(metadata).map(imageFormat => {
      return `  <source type="${imageFormat[0].sourceType}" sizes="100vw" srcset="${imageFormat.map(entry => entry.srcset).join(", ")}" media="(min-width: 0px)">`;
    }).join("\n")}

      <img class="gallery" src="${lowsrc.url}" alt="${alt}" loading="lazy">
    </picture>`;
}

async function posterShortcode(src, alt, position) {
  let metadata = await Image(src, {
    widths: [600, 800, 1000, 1200, 1400, 1600, 1800],
    formats: ["webp", "jpg"],
    outputDir: "./_site/img",
    sharpWebpOptions: {"quality": 80},
    sharpJpegOptions: {"quality": 80,
                       "progressive": true,
                       "trellisQuantisation": true,
                       "overshootDeringing": true,
                       "optimiseScans": true,
                       "quantisationTable": 3},
    filenameFormat: function (id, src, width, format, options) {
      const extension = path.extname(src);
      const name = path.basename(src, extension);

      return `${name}.${width}w.${format}`;
    }
  });

  let lowsrc = metadata.jpeg[0];

  return `<picture>
    ${Object.values(metadata).map(imageFormat => {
      return `  <source type="${imageFormat[0].sourceType}" sizes="max(50vw, 100vh)" media="(min-width: 1024px)" srcset="${imageFormat.map(entry => entry.srcset).join(", ")}">`;
    }).join("\n")}
    ${Object.values(metadata).map(imageFormat => {
      return `  <source type="${imageFormat[0].sourceType}" sizes="100vmax" srcset="${imageFormat.map(entry => entry.srcset).join(", ")}">`;
    }).join("\n")}
      <img
        class="poster"
        src="${lowsrc.url}"
        alt="${alt}"
        style="object-position: ${position};"
        loading="lazy"
        decoding="async">
    </picture>`;
}

module.exports = function(eleventyConfig) {
  let text = yaml.load(fs.readFileSync('./src/_data/text.yaml', 'utf8'));
  eleventyConfig.on('beforeBuild', () => {
    text = yaml.load(fs.readFileSync('./src/_data/text.yaml', 'utf8'));
  });
  eleventyConfig.setUseGitIgnore(false);
  eleventyConfig.setDataDeepMerge(true);

  // human readable date
  eleventyConfig.addFilter("readableDate", (dateObj) => {
    return DateTime.fromJSDate(dateObj, { zone: "utc" }).toFormat(
      "LLL d, yyyy"
    );
  });

  eleventyConfig.addFilter("sprintf", (value, template) => {
    return sprintf(template, value);
  });

  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.addDataExtension("yaml", (contents) =>
    yaml.safeLoad(contents)
  );

  // Copy Netlify redirects
  eleventyConfig.addPassthroughCopy("./src/_redirects");
  eleventyConfig.addPassthroughCopy({"./src/img/{twitter,og}.png": "."});

  eleventyConfig.addPassthroughCopy("./src/static/fonts");
  eleventyConfig.addPassthroughCopy("./src/static/img");

  // Copy book
  eleventyConfig.addPassthroughCopy("./src/2e");

  // Copy favicons to /_site
  eleventyConfig.addPassthroughCopy({"./src/favicons/*.*": "."});



  var env = nunjucks.configure();

  let markdownIt = require("markdown-it");

  let options = {
    html: true,
    breaks: false,
    linkify: true,
    typographer: true,
  };

  const md = new markdownIt({
    html: true,
    breaks: true,
    linkify: true,
    typographer: true,
  });

  eleventyConfig.setLibrary("md", markdownIt(options).use(require('markdown-it-footnote')));

  eleventyConfig.addFilter("markdown", (content) => {
    return md.renderInline(content);
  });

  eleventyConfig.addFilter("selectone", (objs, key, value) => {
    for (const obj of objs) {
      if (obj[key] == value) {
        return obj
      }
    }
  });

  eleventyConfig.addFilter('log', value => {
      console.log(value)
  });

  eleventyConfig.addShortcode("t", function(textObj) {

    let content = ""

    if (typeof textObj === 'string') {
      content = text[textObj]
    } else {
      content = textObj
    }

    try {
      result = md.render(content)
    } catch (e) {
      result = ""
    }

    result = result.trim().replace(/^<p>/, "").replace(/<\/p>$/, "")
    return env.filters.safe(result)
  });

  eleventyConfig.addNunjucksAsyncShortcode("poster", posterShortcode);

  return {
    dir: {
      input: "src",
    },
    htmlTemplateEngine: "njk",
  };
};
