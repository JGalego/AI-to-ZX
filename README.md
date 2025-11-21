# AI to ZX 🧠🌈

## Overview

**AI to ZX** is a collection of artificial intelligence (AI) and computational demonstrations running on the legendary ZX Spectrum computer.

This project bridges the gap between retro computing nostalgia and modern AI concepts by implementing classic algorithms within 1980s hardware constraints.

Programs are written in ZX BASIC, compiled to Z80 machine code, and run in a web-based emulator (JSSpeccy).

**[📼 Try the demos online →](https://jgalego.github.io/AI-to-ZX/)**

![](assets/images/zx_spectrum_enter.gif)

## Prerequisites

To build and run this project locally, you'll need the following tools installed on your system:

- 🐍 **Python 3.11+** is required to run the ZX BASIC compiler
- **bash** for running build scripts (pre-installed on macOS/Linux, use WSL on Windows)
- **curl** for downloading JSSpeccy emulator files
- **unzip** for extracting downloaded archives  
- **jq** for generating demo metadata

## Getting Started

1. Clone the repository

   ```bash
   git clone --recursive https://github.com/JGalego/AI-to-ZX.git
   cd AI-to-ZX
   ```

2. Download JSSpeccy emulator

   ```bash
   ./scripts/download-jsspeccy.sh
   ```

3. Build the demos

   ```bash
   # Build all demos
   ./scripts/build.sh
   
   # or a specific demo
   ./scripts/build.sh Perceptron
   ```

4. Serve locally

   ```bash
   # Using Python's built-in server
   python3 -m http.server 8000 --directory public
   
   # or using any other web server
   cd public && npx serve
   ```

5. Open in the browser

    ![](assets/images/ai_to_zx.png)

## References

### Books 📚

* (Brain & Brain, 1984) [Artificial Intelligence on the Spectrum Computer: Make Your Micro Think](https://spectrumcomputing.co.uk/entry/2000035/Book/Artificial_Intelligence_on_the_Spectrum_Computer_Make_Your_Micro_Think)
* (Hartnell, 1984) [Exploring Artificial Intelligence on your Spectrum+ and Spectrum](https://archive.org/details/timhartnellvz200giantbookofgames/TimHartnell_ExploringArtificialIntelligenceOnYourSpectrum/)
* (James, 1984) [Artificial Intelligence in Basic](https://www.sciencedirect.com/book/monograph/9780408013734/artificial-intelligence-in-basic)
* (Jones & Fairhurst, 1984) [Artificial Intelligence: ZX Spectrum](https://spectrumcomputing.co.uk/entry/2000463/Book/Artificial_Intelligence_ZX_Spectrum)
* (Monteil & Schomberg, 1985) [Programmes d'Inteligence Artificielle en BASIC](https://spectrumcomputing.co.uk/entry/2001181/)
* (Williams, 1986) [The Intelligent Micro: Artificial Intelligence for Microcomputers](https://zxinfo.dk/details/2000686)

### Blogs ✍️

* (Ai-Ai-OH, 2025) [AI and Me: From ZX Spectrums to chatbots](https://medium.com/ai-ai-oh/ai-and-me-09e920a2fd05)
* (CppCMS, 2019) [Modern AI and Deep Learning on ZX Spectrum](https://blog.cppcms.com/post/125)
* (MarkRound, 2021) [DevOps for the Sinclair Spectrum - Part 1](https://www.markround.com/blog/2021/12/21/devops-for-the-sinclair-spectrum-part-1)
* (MrKWatkins, 2025a) [Teaching an AI to Play ZX Spectrum Games](https://www.mrkwatkins.co.uk/teaching-an-ai-to-play-zx-spectrum-games/)
* (MrKWatkins, 2025b) [More on Teaching an AI to Play ZX Spectrum Games](https://www.mrkwatkins.co.uk/more-on-teaching-an-ai-to-play-zx-spectrum-games/)
* (RichHewlett, 2021) [Coding in Spectrum Basic Again](https://richhewlett.com/2021/06/12/coding-in-spectrum-basic-again/)

### Tools & Software 🧰

* [BAS2TAP](https://github.com/speccyorg/bas2tap) - a simple utility to convert BASIC in an ASCII file to a TAP tape image file
* [FUSE](https://fuse-emulator.sourceforge.net/) - a ZX Spectrum emulator for various platforms
* [ZX BASIC](https://zxbasic.readthedocs.io/) - a BASIC cross-compiler for the ZX Spectrum
* [JSSpeccy](https://github.com/gasman/jsspeccy3) - A JavaScript-based ZX Spectrum emulator that runs in web browsers

### Miscellaneous

* [Load ZX](https://loadzx.com/en/) - a museum dedicated to our first personal computer
* [Spectrum Computing](https://spectrumcomputing.co.uk/) - the largest archive of ZX Spectrum software, games, and resources
* [World of Spectrum](https://worldofspectrum.org/) - a comprehensive resource for ZX Spectrum enthusiasts
* [ZX Art](https://zxart.ee/eng/mainpage/) - ZX Spectrum graphics and art repository
* [ZXDB](https://github.com/zxdb/ZXDB) - open database with historical information about Sinclair machines
* [ZXInfo](https://zxinfo.dk/) - a web-app for the ZXDB based search engine

![](assets/images/zx_spectrum_graphics.gif)