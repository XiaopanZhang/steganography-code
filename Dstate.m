function stat = Dstate(D, Filt)
    DPadded = padarray(D, size(Filt), 'symmetric');
	DStat = conv2(DPadded, Filt, 'same');
	sizeD = size(D);
	stat = DStat(((size(DStat, 1)-sizeD(1))/2)+1:end-((size(DStat, 1)-sizeD(1))/2), ((size(DStat, 2)-sizeD(2))/2)+1:end-((size(DStat, 2)-sizeD(2))/2));
end