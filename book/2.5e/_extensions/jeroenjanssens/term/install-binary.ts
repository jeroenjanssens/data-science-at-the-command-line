// Pre-render script: downloads the quarto-term binary matching the extension version.
// Runs automatically before each render; skips download if the correct version is cached.

import { parse as parseYaml } from "https://deno.land/std@0.224.0/yaml/mod.ts";
import { ensureDir } from "https://deno.land/std@0.224.0/fs/mod.ts";
import { join, dirname, fromFileUrl } from "https://deno.land/std@0.224.0/path/mod.ts";

const REPO = "jeroenjanssens/quarto-term";

export function detectPlatform(): string {
  const os = Deno.build.os;
  const arch = Deno.build.arch;

  if (os === "darwin") {
    return arch === "aarch64" ? "aarch64-apple-darwin" : "x86_64-apple-darwin";
  } else if (os === "linux") {
    return arch === "aarch64" ? "aarch64-unknown-linux-gnu" : "x86_64-unknown-linux-gnu";
  } else if (os === "windows") {
    return "x86_64-pc-windows-msvc";
  }
  throw new Error(`Unsupported platform: ${os}/${arch}`);
}

export function binaryName(platform: string): string {
  const ext = platform.includes("windows") ? ".exe" : "";
  return `quarto-term-${platform}${ext}`;
}

async function main() {
  const scriptDir = dirname(fromFileUrl(import.meta.url));
  const binDir = join(scriptDir, "bin");

  // Read version from _extension.yml
  const extYaml = await Deno.readTextFile(join(scriptDir, "_extension.yml"));
  const ext = parseYaml(extYaml) as Record<string, unknown>;
  const version = ext.version as string;
  if (!version) {
    throw new Error("No version found in _extension.yml");
  }

  const platform = detectPlatform();
  const binName = binaryName(platform);
  const binPath = join(binDir, binName);
  const versionFile = join(binDir, ".version");

  // Check if we already have the correct version
  try {
    const cached = (await Deno.readTextFile(versionFile)).trim();
    if (cached === version) {
      try {
        await Deno.stat(binPath);
        return; // Binary exists and version matches
      } catch {
        // Binary missing, re-download
      }
    }
  } catch {
    // No version file, need to download
  }

  await ensureDir(binDir);

  const url = `https://github.com/${REPO}/releases/download/v${version}/${binName}`;
  console.log(`quarto-term: downloading v${version} for ${platform}...`);

  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(
      `Failed to download binary from ${url} (${response.status} ${response.statusText}). ` +
      `Make sure release v${version} exists with asset ${binName}.`
    );
  }

  const bytes = new Uint8Array(await response.arrayBuffer());
  await Deno.writeFile(binPath, bytes);

  // Make executable on Unix
  if (Deno.build.os !== "windows") {
    await Deno.chmod(binPath, 0o755);
  }

  // Write version marker
  await Deno.writeTextFile(versionFile, version);

  console.log(`quarto-term: installed v${version} (${binName})`);
}

if (import.meta.main) {
  main().catch((err) => {
    console.error(`quarto-term: ${err.message}`);
    console.error("quarto-term: falling back to binary on PATH or development build");
  });
}
