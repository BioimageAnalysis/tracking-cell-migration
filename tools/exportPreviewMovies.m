function exportPreviewMovies(dirList)

tmpExportDir = 'D:\Projects\Research\2022 woundhealing\20240801_export';
pat = characterListPattern(':\');

for ii = 1:numel(dirList)

    %Find well directories
    currDirList = getDirList(dirList{ii});

    %Get a list of all directories with timepoints
    candidateDirs = {currDirList.name};

    tokens = regexp(candidateDirs, 'well (?<loc>\w+)', 'names');
    isMatch = cellfun(@(x) numel(x) > 0, tokens);

    validDirs = currDirList(isMatch);

    for kk = 1:numel(validDirs)

        currFiles = dir(fullfile(validDirs(kk).folder, validDirs(kk).name, '*wavelength 1*.tif'));

        if numel(currFiles) > 0

            %Make new folder
            expFolder = replace(validDirs(kk).folder, pat, '_');
            if ~exist(fullfile(tmpExportDir, expFolder), 'dir')
                mkdir(fullfile(tmpExportDir, expFolder))
            end

            [~, wellFolder] = fileparts(currFiles(1).folder);

            vid = VideoWriter(fullfile(tmpExportDir, expFolder, [wellFolder, '.avi']));
            open(vid)

            for ff = 1:numel(currFiles)

                I = imread(fullfile(currFiles(ff).folder, currFiles(ff).name));
                I = im2double(I);

                writeVideo(vid, I);

            end
            close(vid)



        end
    end
end

end

function rootDirList = getDirList(rootDir)

rootDirList = dir(rootDir);
dirFlags = [rootDirList.isdir] & ~strcmp({rootDirList.name},'.') & ~strcmp({rootDirList.name},'..');
rootDirList = rootDirList(dirFlags);

end