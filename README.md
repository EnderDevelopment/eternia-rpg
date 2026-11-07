# Minecraft RPG Modpack

Legends of Eternia RPG is a Fabric 1.20.1 Minecraft modpack focused on RPG progression, exploration, combat, bosses, quests, dungeons, structures, and performance. It combines character options, improved equipment, challenging encounters, repeatable objectives, world generation, shaders, and optimization through compatible Modrinth releases.

## Install

Requirements:

- Minecraft 1.20.1
- Fabric Loader for Minecraft 1.20.1
- Java 17
- Windows: PowerShell 5.1 or newer
- Linux or macOS: Bash, curl, and jq
- Recommended: 4–6 GB of memory allocated to Minecraft

1. Install Fabric Loader for Minecraft 1.20.1.
2. Download this project and open a terminal in its folder.
3. On Windows, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\install_pack.ps1
```

4. On Linux or macOS, run:

```bash
bash install_pack.sh
```

5. Move the generated `mods` folder into your Minecraft game directory, or install directly into the game directory:

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\install_pack.ps1 -GameDir "C:\path\to\.minecraft"
```

Linux or macOS:

```bash
bash install_pack.sh --game-dir "$HOME/.minecraft"
```

6. Launch the Fabric 1.20.1 profile.

The installers retrieve the newest compatible Modrinth release for each project listed in `pack.json`. They report unavailable releases and failed downloads.

## Use

1. Create or open a world with the installed Fabric profile.
2. Explore varied terrain, dungeons, structures, and generated locations.
3. Improve your character with Origins, Artifacts, Trinkets, Simply Swords, Better Combat, and Combat Roll.
4. Travel with Waystones and collect additional loot through Lootr.
5. Face encounters from Bosses of Mass Destruction and AdventureZ.
6. Use Bountiful for repeatable bounty objectives.
7. Open the FTB Quests interface with `/ftbquests`. FTB Quests, FTB Library, and FTB Teams provide the quest framework, but this project does not bundle a custom quest chapter.
8. Improve visuals with Sodium, Iris, and the included performance mods. Shader support depends on the selected shader and system hardware.
9. Edit `pack.json` to add or remove Modrinth project slugs, then run the appropriate installer again.

---

More Minecraft mod projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/0c0b6554-51c5-442a-8fc5-ea9d0c9c039f?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=0c0b6554-51c5-442a-8fc5-ea9d0c9c039f
