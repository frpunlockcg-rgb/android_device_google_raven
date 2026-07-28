# AGENTS.md — device/google/raven (Pixel 6 Pro TWRP)

## What this is

TWRP device tree for Google Pixel 6 Pro (raven), generated via SebaUbuntu's TWRP device tree generator. Built against the minimal-manifest-twrp AOSP tree.

## Build (from CI workflow)

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1 --depth=1
repo sync -j$(nproc) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh
lunch twrp_raven-eng
mka bootimage -j$(nproc)
```

Output: `out/target/product/raven/boot.img`.

Use `fastboot boot boot.img` to boot TWRP without flashing.

## Key device tree layout

| Path | Purpose |
|---|---|
| `BoardConfig.mk` | Board config: gs101 SoC, arm64, A/B slots, super partition, AVB, boot header v4, prebuilt kernel |
| `device.mk` | Shared product packages (boot HAL, update_engine) |
| `omni_raven.mk` | OmniROM product definition |
| `twrp_raven.mk` | TWRP product definition (inherits `vendor/twrp/config/common.mk`) |
| `bootctrl/bootctrl.cpp` | Boot control HAL stub for recovery (gs101 variant, exposed as `bootctrl.gs101.recovery`) |
| `recovery/root/` | Recovery init .rc files |
| `prebuilt/kernel`, `prebuilt/dtb.img`, `prebuilt/dtbo.img` | Prebuilt kernel artifacts (no kernel source here) |
| `recovery.fstab` | Partition mount table (slotselect for logical partitions) |

## Important quirks

- **No kernel compilation** — `TARGET_FORCE_PREBUILT_KERNEL := true`, kernel is prebuilt. Must also set `BOARD_PREBUILT_DTBIMAGE_DIR` and `BOARD_PREBUILT_DTBOIMAGE` so ninja has rules to copy dtb.img/dtbo.img into `out/` for recovery.img dependency.
- **Anti-rollback hack** — `PLATFORM_SECURITY_PATCH := 2099-12-31` and `VENDOR_SECURITY_PATCH := 2099-12-31`.
- **AVB with flags 3** — `--flags 3` disables verification (for custom recovery).
- **ALLOW_MISSING_DEPENDENCIES := true** — Required for minimal manifest builds.
- **Boot header v4** — `BOARD_BOOTIMG_HEADER_VERSION := 4`, uses `--header_version`, `--ramdisk_offset`, `--tags_offset` in mkbootimg args.
- **Virtual A/B** — `AB_OTA_UPDATER := true` with slotselect on boot, system, vbmeta, etc.
- **FBE with fscrypt v2** — `TW_INCLUDE_CRYPTO_FBE := true`, `TW_USE_FSCRYPT_POLICY := 2`.
- **Repack tools included** — `TW_INCLUDE_REPACKTOOLS := true`.
- **Place this repo at `device/google/raven/`** inside the AOSP/TWRP source tree. The CI checks it out to `twrp/device/google/raven/`.

## Available lunch combos

From `AndroidProducts.mk`:
- `twrp_raven-eng`, `twrp_raven-userdebug`
- `omni_raven-user`, `omni_raven-userdebug`, `omni_raven-eng`

## Extract flow

`extract-files.sh` and `setup-makefiles.sh` use `tools/extract-utils/extract_utils.sh` from the AOSP tree. They read `proprietary-files.txt` (not checked into this repo — generated at extract time).
