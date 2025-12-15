clc;

% coverPath = '/data/wkk/ALASKA20000_Spatial1/ALASKA_v2_TIFF_256_COLOR_RANDOM1/';
coverPath = 'D:\UCNetdataset\cover1';
img_list = dir(strcat(coverPath, '*.ppm'));
payload=0.4;
params.p = -1;

parfor i= 1:length(img_list)
    img_name = img_list(i).name;
    img = strcat(coverPath, img_name);
    img_path=fullfile(img);
    cover=imread(img_path);
    
    stego = Color_CMD_S(cover, payload);
   
    % imwrite(stego,['/data/wkk/ALASKA20000_Spatial1/ALASKA_v2_TIFF_256_COLOR_SUNIWARD-CMDC_0.4_norandom/', fullname(i), '.ppm']);
    imwrite(stego,['D:\UCNetdataset\stego1\256ppm_CMDC-SUNIWARD_0.4', fullname(i), '.ppm']);
end