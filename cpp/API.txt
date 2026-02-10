NO_INLINE void KAPI_Ver4(){
	int initialized = 0x11C1FF20;
	int kernelAdPtr = 0x11C1FF40;
	int SingleAdPtr = 0x11C1FF44;
	int AddMsgAdPtr = 0x11C1FF48;
	int *kernelAd = (int*)0x11C20000;
	int SingleAd = 0x11C30000;
	int AddMsgAd = 0x11C40000;
	*(uint32_t*)kernelAdPtr = 0x11C20000;
	*(uint32_t*)SingleAdPtr = 0x11C30000;
	*(uint32_t*)AddMsgAdPtr = 0x11C40000;

	for(int kernelset = 0; kernelAd[kernelset] != 0; kernelset += 2){
		kernel_write_value(kernelAd[kernelset], kernelAd[kernelset + 1]);
		kernelAd[kernelset] = 0;
		kernelAd[kernelset + 1] = 0;
	}

	int setVoid = 0x11C1FF0C;
	int setRange = 0x11C1FF08;
	uint32_t end = 0xFEFEFEFE;
	*(int*)setRange = 0xFFFF;

	if(*(int*)SingleAd){
		KAPI_OLD_Handle::setSingleMessage(SingleAd);
		for(int ad = SingleAd; ad < SingleAd + *(int*)setRange; ad += 4){
			*(int*)ad = *(int*)setVoid;
		}
	}

	if(*(int*)AddMsgAd){
		int ad = AddMsgAd;
		KAPI_OLD_Handle::addMessage(ad);
		for(int iad = AddMsgAd; iad < AddMsgAd + *(int*)setRange; iad += 2){
			if(*(uint32_t*)ad == end && *(uint32_t*)(iad+0x20)) KAPI_OLD_Handle::addMessage(iad+0x20);
			*(int*)iad = *(int*)setVoid;
		}
	}

	*(bool*)initialized = true;

	executeAssemblyReturn();
}