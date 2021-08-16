
Folder = dir('output_pre\');
Folder2 = dir('output\');
totalSimilarity=0;
total=0;
for j = 1 : 5
    File = dir(strcat('output_pre\',int2str(j),'\*.bmp'));
    File2 = dir(strcat('output\',int2str(j),'\*.bmp'));
    for i = 1 : length(File)
        filename2 = strcat('output\',int2str(j),'\',int2str(i),'.bmp');
        groundTruth =  imread(filename2);
        filename = strcat('output_pre\',int2str(j),'\',int2str(i),'.bmp');%,File(i).name);
        img = imread(filename);
        R = imadjust(img(:,:,1));
        R = medfilt2(R);
        G = imadjust(img(:,:,2));
        G = medfilt2(G);
        B = imadjust(img(:,:,3));
        B = medfilt2(B);
        RGB = cat(3,R,G,B);
        HSV = rgb2hsv(im2double(RGB));
        sThresh = HSV(:,:,2) > 0.7 & HSV(:,:,2) < 1;
        final1 = bwareafilt(sThresh,[480,100000000]);
        se = strel('disk',1,0);
        final2 = imdilate(final1,se);
        sim = getJaccard(final2,groundTruth);
        totalSimilarity = totalSimilarity + sim;
        total = total+1;
        fileName = sprintf('%d.bmp',i);
        folder = strcat('myOutput\',int2str(j));
        fullFileName = fullfile(folder,fileName);
        imwrite(final2,fullFileName);
        if (j == 5) && (i == length(File))
            disp(totalSimilarity/total)
        end
    end

end