#include "MyPlugin.h"
#include "../skse/GameReferences.h"
#include "../skse/GameBSExtraData.h"
#include "../skse/GameRTTI.h"

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
		// Return the Linked Door reference of this object reference.

		if (!object) return NULL;
		
		//Get the ExtraTeleport
		ExtraTeleport* teleport = DYNAMIC_CAST(object->extraData.GetByType(kExtraData_Teleport), BSExtraData, ExtraTeleport);
		if (!teleport) return NULL;

		//Get the RefHandle
		UInt32 handle = NULL;
		if (teleport->data)
			handle = teleport->data->refHandle;
		if (handle == (*g_invalidRefHandle) || handle == 0) return NULL;

		//Get the Reference
		TESObjectREFR * reference = NULL;
		LookupREFRByHandle(&handle, &reference);

		return reference;
	}

	bool RegisterFuncs(VMClassRegistry* registry) {
		registry->RegisterFunction(
			new NativeFunction1 <StaticFunctionTag, TESObjectREFR*, TESObjectREFR*>("GetLinkedDoor", "SimplyKnockSKSEScript", SimplyKnockNamespace::GetLinkedDoor, registry));

		return true;
	}
} 
