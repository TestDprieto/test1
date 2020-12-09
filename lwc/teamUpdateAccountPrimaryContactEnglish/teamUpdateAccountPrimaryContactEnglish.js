import { api, track } from 'lwc';
import OmniscriptHeader from 'vlocity_cmt/omniscriptHeader';
import { allCustomLabels } from 'vlocity_cmt/omniscriptCustomLabels';
import { OMNIDEF } from './teamUpdateAccountPrimaryContactEnglish_def.js';
import tmpl from './teamUpdateAccountPrimaryContactEnglish.html';
import tmpl_nds from './teamUpdateAccountPrimaryContactEnglish_nds.html';

/**
 *  IMPORTANT! Generated class DO NOT MODIFY
 */
export default class teamUpdateAccountPrimaryContactEnglish extends OmniscriptHeader {
    @track jsonDef = {};
    @track resume = false;
    @api layout;
    @api recordId;

    _label = {
        OmniScriptError: allCustomLabels.OmniScriptError,
        OmniScriptNotFound3: allCustomLabels.OmniScriptNotFound3,
        OmniScriptType: allCustomLabels.OmniScriptType,
        OmniScriptSubType: allCustomLabels.OmniScriptSubType,
        OmniScriptLang: allCustomLabels.OmniScriptLang,
        OmniScriptNotFound2: allCustomLabels.OmniScriptNotFound2,
        OmniInvalidLwcComponentMessage: allCustomLabels.OmniInvalidLwcComponentMessage,
        OmniInvalidLwcComponent: allCustomLabels.OmniInvalidLwcComponent,
        OmniContinue: allCustomLabels.OmniContinue,
        OmnicancelLabel: allCustomLabels.OmnicancelLabel
    }

    connectedCallback() {
        // We don't need the full JSON def if we are opening a save for later
        this.jsonDef = this.instanceId ?
                        {
                            sOmniScriptId: OMNIDEF.sOmniScriptId,
                            lwcId: OMNIDEF.lwcId,
                            labelMap: OMNIDEF.labelMap,
                            propSetMap: OMNIDEF.propSetMap,
                            bpType: OMNIDEF.bpType,
                            bpSubType: OMNIDEF.bpSubType,
                            bpLang: OMNIDEF.bpLang
                        } :
                        JSON.parse(JSON.stringify(OMNIDEF));
        this.resume = !!this.instanceId;
        super.connectedCallback();
    }

    handleContinueInvalidSfl() {
        this.jsonDef = JSON.parse(JSON.stringify(OMNIDEF));
        super.handleContinueInvalidSfl();
    }

    render() {
        return this.layout === 'newport' ? tmpl_nds : tmpl;
    }
}