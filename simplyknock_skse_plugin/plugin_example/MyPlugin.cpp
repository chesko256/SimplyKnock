#include "MyPlugin.h"
#include "../skse/GameReferences.h"
#include "../skse/GameBSExtraData.h"

// 0C
class ExtraTeleport : public BSExtraData
{
public:
	virtual ~ExtraTeleport();

	// 20
	struct Data
	{
		UInt32   refHandle;
		float    unk04;
		float    unk08;
		float    unk0C;
		float    unk10;
		float    unk14;
		float    unk18;
		UInt8    unk1C;
	};
	Data * data;
};

namespace SimplyKnockNamespace {
	TESObjectREFR * GetLinkedDoor(StaticFunctionTag *base, TESObjectREFR* object) {
		_MESSAGE("GetLinkedDoor() will simply return the object supplied to it for now.");
		return object;
	}

	bool RegisterFuncs(VMClassRegistry* registry) {
		registry->RegisterFunction(
			new NativeFunction1 <StaticFunctionTag, TESObjectREFR*, TESObjectREFR*>("GetLinkedDoor", "SimplyKnockSKSEScript", SimplyKnockNamespace::GetLinkedDoor, registry));

		return true;
	}
} 
