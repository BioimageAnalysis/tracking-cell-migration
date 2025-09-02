# Tracking cell migration

The goal of this project is to understand the rules governing cell migration. This code identifies and tracks fluorescently-labeled cell nuclei captured using the Revvity (formerly Perkin Elmer) Opera Phenix imager. The project is a collaboration between the Liu lab, the Bortz lab, and the BioFrontiers Bioimage Analysis Group.

## Algorithm description

The code first identifies cell nuclei using the difference of Gaussian filter. Objects above a specified quality factor are identified as being nuclei. Watershedding is then applied to split any touching nuclei. The centroid of the detected nuclei are then measured and used to generate individual tracks through a nearest-neighbor algorithm [^1]. The linking problem is composed using the linear assignment framework [^2] and solved using the Jonker-Volgenant algorithm[^3]. After processing is completed, the tracks are then filtered to retain only nuclei which are tracked for at least 90% of the length of the movie.

### Known limitations

* Nuclei moving very close to/on top of each other might cause a track to break or the wrong object to be assigned the wrong ID.
* Nuclei leaving/entering the field of view might not be accurately tracked.

## How to use

### Requirements

* MATLAB (R2023b or later) with the following toolboxes:
  * Computer Vision Toolbox
  * Image Processing Toolbox
  * Parallel Processing Toolbox
  * [Bioformats Image Toolbox](https://github.com/Biofrontiers-ALMC/bioformats-matlab/releases/tag/v1.2.3) (v 1.2.3 or later)
  * [Cell Tracking Toolbox](https://github.com/Biofrontiers-ALMC/cell-tracking-toolbox/releases/tag/v2.1.1) (v 2.1.1 or later)

**Note:** The first two toolboxes are shipped with MATLAB and can be installed using the MATLAB installer. The latter two can be downloaded using the links above. After downloading, simply open the *.mltbx files with MATLAB to install.

### Download files

1. Download the latest version as a Zip file from [Releases](https://github.com/Biofrontiers-ALMC/17537-Vesicle-Fusion/releases).

2. Extract the file e.g., to your MATLAB folder.

3. Right-click on the folder, the select "Add to Path" > "Selected folders"

### Example script

An example script is provided in ``run_example.m``.

### Tracking nuclei

To track nuclei:

1. Create a new ECMCellTracker object
   ```matlab
   T = ECMCellTracker
   ```

2. Set parameters (if necessary)
   ```matlab
   T.NucleiQuality = 10;

   %Enable parallel processing
   T.ParallelProcess = true
   ```

3. Process your movies
   ```matlab
   process(T)
   ```

#### Output

For each location processed, the code outputs a number of files:
   * An AVI-file showing the outline and ID of detected nuclei
   * A MAT-file containing information about the tracked nuclei
   * A text file of the parameters used to process the movie

The following variables should be present in the MAT-file:
   * 'tracks' and 'trackStruct' both containing the same information
   about tracked cells (see
   https://github.com/Biofrontiers-ALMC/cell-tracking-toolbox/wiki/overview-trackarray)
   * 'isTrackValid' - a logical array showing if the indexed track is
   has a length of at least 90% of the movie.  

## Frequently Asked Questions (FAQs)

1. What value should I set for the ``MaxLinkingDistance``?
   
   ``MaxLinkingDistance`` should be set to the average maximum displacement of a cell/nuclei between two frames. One way to estimate this is to open the movie in ImageJ/Fiji and use the line tool to estimate the distance moved between frames.

   Generally, if the results show tracks too many nuclei "switching" IDs, it's likely this value is too high (it's linking unrelated cells). However, if a single nuclei is being assigned a new ID every frame, then the value is too low.

2. How do I enable parallel processing?
   
   Parallel processing uses your computer's multiple CPU cores to process multiple files at once. This _may_ speed up the process, provided you have sufficient RAM to hold all the data. To enable, set the property ``ParallelProcess`` to ``true``.

   Example:
   ```matlab
   T = ECMCellTracker;
   T.ParallelProcess = true;
   ```

## Reporting issues

If you encounter any issues or difficulties:

* Send an email to biof-imaging@colorado.edu
* Create an [issue](https://github.com/Biofrontiers-ALMC/17537-Vesicle-Fusion/issues)

## Acknowledge us

See [here](https://biof-imagewiki.colorado.edu/books/facility-guidelines/page/recognizing-the-core) for guidelines.

### References

[^1]: Jian Wei Tay and Jeffrey C. Cameron. Computational and biochemical methods to measure the activity of carboxysomes and protein organelles in vivo. In Methods in Enzymology, Editor(s) Joseph Jez. (2023). https://doi.org/10.1016/bs.mie.2022.09.010
[^2]: Jaqaman, K., Loerke, D., Mettlen, M. et al. Robust single-particle tracking in live-cell time-lapse sequences. Nat Methods 5, 695–702 (2008). https://doi.org/10.1038/nmeth.1237
[^3]: Jonker R, and Volgenant A. A shortest augmenting path algorithm for dense and sparse linear assignment problems. Computing 38, 325 (1987). https://doi.org/10.1007/978-3-642-73778-7_164

### Changelog (Major changes only)

Sep-2-2025 - Added files to calculate ratiometric videos
Mar-6-2025 - Added code to read in updated Harmony format
Dec-6-2024 - Modified code to also measure donor and acceptor intensities