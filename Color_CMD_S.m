function stego = Color_CMD_S(cover, payload)

cover = double(cover);
stego = cover;
wetCost = 10^10;
R_cover = cover(:,:,1);
G_cover = cover(:,:,2);
B_cover = cover(:,:,3);
R_stego = stego(:,:,1);
G_stego = stego(:,:,2);
B_stego = stego(:,:,3);
% compute embedding costs
R_rho = S_UNIWARD(R_cover);
G_rho = S_UNIWARD(G_cover);
B_rho = S_UNIWARD(B_cover);
%----------------------------------------分块嵌入----------------------------------------------
L = 2; %分块的长和宽
alpha = 9.0;
scanStart = 1; %扫描开始位置
scanEnd = L; %扫描结束位置
scanDir = 1; %扫描方向，1是从左->右，-1为从右向左，以下为“之”字型扫描

for sRow = 1:1:L

	for sCol = scanStart:scanDir:scanEnd

	%----------------红色通道------------------------------------------------------------------------
    R_DStat = Dstate(R_stego - R_cover, [0 1 0;1 1 1;0 1 0])+(G_stego - G_cover)+(B_stego - B_cover);

	sub_Block = R_cover(sRow:L:end,sCol:L:end);
	sub_Rho = R_rho(sRow:L:end,sCol:L:end);
	sub_DStat = R_DStat(sRow:L:end,sCol:L:end);


	% adjust embedding costs
	sub_Rho(sub_Rho > wetCost) = wetCost; % threshold on the costs
	sub_Rho(isnan(sub_Rho)) = wetCost; % if all xi{} are zero threshold the cost
	subRhoP1 = sub_Rho;
	subRhoM1 = sub_Rho;
	subRhoP1(sub_DStat>0) = subRhoP1(sub_DStat>0)/alpha;
	subRhoM1(sub_DStat<0) = subRhoM1(sub_DStat<0)/alpha;
	subRhoP1(sub_Block==255) = wetCost; % do not embed +1 if the pixel has max value
	subRhoM1(sub_Block==0) = wetCost; % do not embed -1 if the pixel has min value

	% Embedding simulator
	subStego = CSCMD_EmbeddingSimulator(sub_Block, subRhoP1, subRhoM1, payload*numel(sub_Block), false);
        
	R_stego(sRow:L:end,sCol:L:end) = subStego;

	%----------------绿色通道------------------------------------------------------------------------
        G_DStat = Dstate(G_stego - G_cover, [0 1 0;1 1 1;0 1 0])+(R_stego - R_cover)+(B_stego - B_cover);

	sub_Block = G_cover(sRow:L:end,sCol:L:end);
	sub_Rho = G_rho(sRow:L:end,sCol:L:end);
	sub_DStat = G_DStat(sRow:L:end,sCol:L:end);


	% adjust embedding costs
	sub_Rho(sub_Rho > wetCost) = wetCost; % threshold on the costs
	sub_Rho(isnan(sub_Rho)) = wetCost; % if all xi{} are zero threshold the cost
	subRhoP1 = sub_Rho;
	subRhoM1 = sub_Rho;
	subRhoP1(sub_DStat>0) = subRhoP1(sub_DStat>0)/alpha;
	subRhoM1(sub_DStat<0) = subRhoM1(sub_DStat<0)/alpha;
	subRhoP1(sub_Block==255) = wetCost; % do not embed +1 if the pixel has max value
	subRhoM1(sub_Block==0) = wetCost; % do not embed -1 if the pixel has min value

	% Embedding simulator
	subStego = CSCMD_EmbeddingSimulator(sub_Block, subRhoP1, subRhoM1, payload*numel(sub_Block), false);
        
	G_stego(sRow:L:end,sCol:L:end) = subStego;

	%----------------蓝色通道------------------------------------------------------------------------
    B_DStat = Dstate(B_stego - B_cover, [0 1 0;1 1 1;0 1 0])+(R_stego - R_cover)+(G_stego - G_cover);

	sub_Block = B_cover(sRow:L:end,sCol:L:end);
	sub_Rho = B_rho(sRow:L:end,sCol:L:end);
	sub_DStat = B_DStat(sRow:L:end,sCol:L:end);


	% adjust embedding costs
	sub_Rho(sub_Rho > wetCost) = wetCost; % threshold on the costs
	sub_Rho(isnan(sub_Rho)) = wetCost; % if all xi{} are zero threshold the cost
	subRhoP1 = sub_Rho;
	subRhoM1 = sub_Rho;
	subRhoP1(sub_DStat>0) = subRhoP1(sub_DStat>0)/alpha;
	subRhoM1(sub_DStat<0) = subRhoM1(sub_DStat<0)/alpha;
	subRhoP1(sub_Block==255) = wetCost; % do not embed +1 if the pixel has max value
	subRhoM1(sub_Block==0) = wetCost; % do not embed -1 if the pixel has min value

	% Embedding simulator
	subStego = CSCMD_EmbeddingSimulator(sub_Block, subRhoP1, subRhoM1, payload*numel(sub_Block), false);
        
	B_stego(sRow:L:end,sCol:L:end) = subStego;

    end
    tmp = scanStart;
    scanStart = scanEnd;
    scanEnd = tmp;
    scanDir = -1*scanDir;
    
end


stego(:,:,1) = R_stego;
stego(:,:,2) = G_stego;
stego(:,:,3) = B_stego;
stego=uint8(stego);
end