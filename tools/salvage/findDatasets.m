%This script was written to parse through the hard drive and try to
%identify folders with at least 2050 time points.
%
%  Timepoint folders have TimePoint_01

startingDir = 'H:\1';
%startingDir = 'D:\Projects\Research\2022 woundhealing\code2\tools\test';

validDirs = parseDirectory(startingDir, {});

exportPreviewMovies(validDirs)


function rootDirList = getDirList(rootDir)

rootDirList = dir(rootDir);
dirFlags = [rootDirList.isdir] & ~strcmp({rootDirList.name},'.') & ~strcmp({rootDirList.name},'..');
rootDirList = rootDirList(dirFlags);

end

function output = parseDirectory(root, output)

    dirlist = getDirList(root);

    for ii = 1:numel(dirlist)

        if startsWith(dirlist(ii).name, 'TimePoint')
            
            %Get a list of all directories with timepoints
            candidateDirs = {dirlist.name};
            
            tokens = regexp(candidateDirs, 'TimePoint_(?<tt>\d+)', 'names');
            isMatch = cellfun(@(x) numel(x) > 0, tokens);
            
            nFrames = nnz(isMatch);

            if nFrames > 50
                output{end + 1} = dirlist(ii).folder;
            end
            
            break
        else
            output = parseDirectory(fullfile(dirlist(ii).folder, dirlist(ii).name), output);
        end
    end
end