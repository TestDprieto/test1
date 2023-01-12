<?xml version="1.0" encoding="UTF-8"?>
<OmniScript xmlns="http://soap.sforce.com/2006/04/metadata">
    <description>sample reusable OmniScript</description>
    <elementTypeComponentMapping>{&quot;ElementTypeToHTMLTemplateList&quot;:[]}</elementTypeComponentMapping>
    <isActive>true</isActive>
    <isIntegrationProcedure>false</isIntegrationProcedure>
    <isMetadataCacheDisabled>false</isMetadataCacheDisabled>
    <isOmniScriptEmbeddable>true</isOmniScriptEmbeddable>
    <isTestProcedure>false</isTestProcedure>
    <isWebCompEnabled>true</isWebCompEnabled>
    <language>English</language>
    <name>Company Mailing Address</name>
    <omniProcessElements>
        <isActive>true</isActive>
        <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
        <level>0.0</level>
        <name>DataRaptorExtractAction1</name>
        <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
        <propertySetConfig>{&quot;controlWidth&quot;:12,&quot;label&quot;:&quot;DataRaptorExtractAction1&quot;,&quot;bundle&quot;:&quot;reusableCompanyMailingAddress&quot;,&quot;ignoreCache&quot;:false,&quot;dataRaptor Input Parameters&quot;:[{&quot;element&quot;:&quot;ContextId&quot;,&quot;inputParam&quot;:&quot;AccountId&quot;}],&quot;remoteTimeout&quot;:30000,&quot;responseJSONPath&quot;:&quot;&quot;,&quot;responseJSONNode&quot;:&quot;&quot;,&quot;inProgressMessage&quot;:&quot;In Progress&quot;,&quot;postMessage&quot;:&quot;Done&quot;,&quot;failureNextLabel&quot;:&quot;Continue&quot;,&quot;failureAbortLabel&quot;:&quot;Abort&quot;,&quot;failureGoBackLabel&quot;:&quot;Go Back&quot;,&quot;failureAbortMessage&quot;:&quot;Are you sure?&quot;,&quot;validationRequired&quot;:&quot;Step&quot;,&quot;redirectPageName&quot;:&quot;&quot;,&quot;redirectTemplateUrl&quot;:&quot;vlcAcknowledge.html&quot;,&quot;redirectNextLabel&quot;:&quot;Next&quot;,&quot;redirectNextWidth&quot;:3,&quot;redirectPreviousLabel&quot;:&quot;Previous&quot;,&quot;redirectPreviousWidth&quot;:3,&quot;showPersistentComponent&quot;:[true,false],&quot;show&quot;:null,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;wpm&quot;:false,&quot;ssm&quot;:false,&quot;message&quot;:{},&quot;pubsub&quot;:false,&quot;errorMessage&quot;:{&quot;custom&quot;:[],&quot;default&quot;:null},&quot;enableDefaultAbort&quot;:false,&quot;enableActionMessage&quot;:false,&quot;businessCategory&quot;:&quot;&quot;,&quot;businessEvent&quot;:&quot;&quot;}</propertySetConfig>
        <sequenceNumber>0.0</sequenceNumber>
        <type>DataRaptor Extract Action</type>
    </omniProcessElements>
    <omniProcessElements>
        <childElements>
            <isActive>true</isActive>
            <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
            <level>1.0</level>
            <name>AccountMailingCity</name>
            <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
            <propertySetConfig>{&quot;controlWidth&quot;:4,&quot;label&quot;:&quot;City&quot;,&quot;showInputWidth&quot;:false,&quot;inputWidth&quot;:12,&quot;required&quot;:false,&quot;repeat&quot;:false,&quot;repeatClone&quot;:false,&quot;repeatLimit&quot;:null,&quot;readOnly&quot;:false,&quot;defaultValue&quot;:null,&quot;help&quot;:false,&quot;helpText&quot;:&quot;&quot;,&quot;helpTextPos&quot;:&quot;&quot;,&quot;mask&quot;:&quot;&quot;,&quot;pattern&quot;:&quot;&quot;,&quot;ptrnErrText&quot;:&quot;&quot;,&quot;minLength&quot;:0,&quot;maxLength&quot;:255,&quot;placeholder&quot;:&quot;&quot;,&quot;show&quot;:null,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;accessibleInFutureSteps&quot;:false,&quot;debounceValue&quot;:0,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;hide&quot;:false,&quot;disOnTplt&quot;:false,&quot;autocomplete&quot;:null}</propertySetConfig>
            <sequenceNumber>1.0</sequenceNumber>
            <type>Text</type>
        </childElements>
        <childElements>
            <isActive>true</isActive>
            <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
            <level>1.0</level>
            <name>AccountMailingCountry</name>
            <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
            <propertySetConfig>{&quot;autocomplete&quot;:null,&quot;disOnTplt&quot;:false,&quot;hide&quot;:false,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;debounceValue&quot;:0,&quot;accessibleInFutureSteps&quot;:false,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;show&quot;:null,&quot;placeholder&quot;:&quot;&quot;,&quot;maxLength&quot;:255,&quot;minLength&quot;:0,&quot;ptrnErrText&quot;:&quot;&quot;,&quot;pattern&quot;:&quot;&quot;,&quot;mask&quot;:&quot;&quot;,&quot;helpTextPos&quot;:&quot;&quot;,&quot;helpText&quot;:&quot;&quot;,&quot;help&quot;:false,&quot;defaultValue&quot;:null,&quot;readOnly&quot;:false,&quot;repeatLimit&quot;:null,&quot;repeatClone&quot;:false,&quot;repeat&quot;:false,&quot;required&quot;:false,&quot;inputWidth&quot;:12,&quot;showInputWidth&quot;:false,&quot;label&quot;:&quot;Country&quot;,&quot;controlWidth&quot;:5}</propertySetConfig>
            <sequenceNumber>4.0</sequenceNumber>
            <type>Text</type>
        </childElements>
        <childElements>
            <isActive>true</isActive>
            <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
            <level>1.0</level>
            <name>AccountMailingPostalCode</name>
            <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
            <propertySetConfig>{&quot;controlWidth&quot;:2,&quot;label&quot;:&quot;Postal Code&quot;,&quot;showInputWidth&quot;:false,&quot;inputWidth&quot;:12,&quot;required&quot;:false,&quot;repeat&quot;:false,&quot;repeatClone&quot;:false,&quot;repeatLimit&quot;:null,&quot;readOnly&quot;:false,&quot;defaultValue&quot;:null,&quot;help&quot;:false,&quot;helpText&quot;:&quot;&quot;,&quot;helpTextPos&quot;:&quot;&quot;,&quot;mask&quot;:&quot;&quot;,&quot;pattern&quot;:&quot;&quot;,&quot;ptrnErrText&quot;:&quot;&quot;,&quot;minLength&quot;:0,&quot;maxLength&quot;:255,&quot;placeholder&quot;:&quot;&quot;,&quot;show&quot;:null,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;accessibleInFutureSteps&quot;:false,&quot;debounceValue&quot;:0,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;hide&quot;:false,&quot;disOnTplt&quot;:false,&quot;autocomplete&quot;:null}</propertySetConfig>
            <sequenceNumber>3.0</sequenceNumber>
            <type>Text</type>
        </childElements>
        <childElements>
            <isActive>true</isActive>
            <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
            <level>1.0</level>
            <name>AccountMailingState</name>
            <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
            <propertySetConfig>{&quot;autocomplete&quot;:null,&quot;disOnTplt&quot;:false,&quot;hide&quot;:false,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;debounceValue&quot;:0,&quot;accessibleInFutureSteps&quot;:false,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;show&quot;:null,&quot;placeholder&quot;:&quot;&quot;,&quot;maxLength&quot;:255,&quot;minLength&quot;:0,&quot;ptrnErrText&quot;:&quot;&quot;,&quot;pattern&quot;:&quot;&quot;,&quot;mask&quot;:&quot;&quot;,&quot;helpTextPos&quot;:&quot;&quot;,&quot;helpText&quot;:&quot;&quot;,&quot;help&quot;:false,&quot;defaultValue&quot;:null,&quot;readOnly&quot;:false,&quot;repeatLimit&quot;:null,&quot;repeatClone&quot;:false,&quot;repeat&quot;:false,&quot;required&quot;:false,&quot;inputWidth&quot;:12,&quot;showInputWidth&quot;:false,&quot;label&quot;:&quot;State&quot;,&quot;controlWidth&quot;:1}</propertySetConfig>
            <sequenceNumber>2.0</sequenceNumber>
            <type>Text</type>
        </childElements>
        <childElements>
            <isActive>true</isActive>
            <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
            <level>1.0</level>
            <name>AccountMailingStreet</name>
            <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
            <propertySetConfig>{&quot;controlWidth&quot;:12,&quot;label&quot;:&quot;Street Address&quot;,&quot;showInputWidth&quot;:false,&quot;inputWidth&quot;:12,&quot;required&quot;:false,&quot;repeat&quot;:false,&quot;repeatClone&quot;:false,&quot;repeatLimit&quot;:null,&quot;readOnly&quot;:false,&quot;defaultValue&quot;:null,&quot;help&quot;:false,&quot;helpText&quot;:&quot;&quot;,&quot;helpTextPos&quot;:&quot;&quot;,&quot;mask&quot;:&quot;&quot;,&quot;pattern&quot;:&quot;&quot;,&quot;ptrnErrText&quot;:&quot;&quot;,&quot;minLength&quot;:0,&quot;maxLength&quot;:255,&quot;placeholder&quot;:&quot;&quot;,&quot;show&quot;:null,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;accessibleInFutureSteps&quot;:false,&quot;debounceValue&quot;:0,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;hide&quot;:false,&quot;disOnTplt&quot;:false,&quot;autocomplete&quot;:null}</propertySetConfig>
            <sequenceNumber>0.0</sequenceNumber>
            <type>Text</type>
        </childElements>
        <isActive>true</isActive>
        <isOmniScriptEmbeddable>false</isOmniScriptEmbeddable>
        <level>0.0</level>
        <name>StepAddress</name>
        <omniProcessVersionNumber>0.0</omniProcessVersionNumber>
        <propertySetConfig>{&quot;label&quot;:&quot;Mailing Address&quot;,&quot;validationRequired&quot;:true,&quot;previousLabel&quot;:&quot;Previous&quot;,&quot;previousWidth&quot;:3,&quot;nextLabel&quot;:&quot;Next&quot;,&quot;nextWidth&quot;:3,&quot;cancelLabel&quot;:&quot;Cancel&quot;,&quot;cancelMessage&quot;:&quot;Are you sure?&quot;,&quot;saveLabel&quot;:&quot;Save for later&quot;,&quot;saveMessage&quot;:&quot;Are you sure you want to save it for later?&quot;,&quot;completeLabel&quot;:&quot;Complete&quot;,&quot;completeMessage&quot;:&quot;Are you sure you want to complete the script?&quot;,&quot;instruction&quot;:&quot;&quot;,&quot;showPersistentComponent&quot;:[true,false],&quot;remoteClass&quot;:&quot;&quot;,&quot;remoteMethod&quot;:&quot;&quot;,&quot;remoteTimeout&quot;:30000,&quot;remoteOptions&quot;:{},&quot;knowledgeOptions&quot;:{&quot;language&quot;:&quot;English&quot;,&quot;publishStatus&quot;:&quot;Online&quot;,&quot;keyword&quot;:&quot;&quot;,&quot;dataCategoryCriteria&quot;:&quot;&quot;,&quot;remoteTimeout&quot;:30000,&quot;typeFilter&quot;:&quot;&quot;},&quot;show&quot;:null,&quot;conditionType&quot;:&quot;Hide if False&quot;,&quot;HTMLTemplateId&quot;:&quot;&quot;,&quot;instructionKey&quot;:&quot;&quot;,&quot;chartLabel&quot;:null,&quot;allowSaveForLater&quot;:true,&quot;errorMessage&quot;:{&quot;custom&quot;:[],&quot;default&quot;:null},&quot;wpm&quot;:false,&quot;ssm&quot;:false,&quot;message&quot;:{},&quot;pubsub&quot;:false,&quot;businessCategory&quot;:&quot;&quot;,&quot;businessEvent&quot;:&quot;&quot;}</propertySetConfig>
        <sequenceNumber>1.0</sequenceNumber>
        <type>Step</type>
    </omniProcessElements>
    <omniProcessType>OmniScript</omniProcessType>
    <propertySetConfig>{&quot;persistentComponent&quot;:[{&quot;render&quot;:false,&quot;label&quot;:&quot;&quot;,&quot;remoteClass&quot;:&quot;&quot;,&quot;remoteMethod&quot;:&quot;&quot;,&quot;remoteTimeout&quot;:30000,&quot;remoteOptions&quot;:{&quot;preTransformBundle&quot;:&quot;&quot;,&quot;postTransformBundle&quot;:&quot;&quot;},&quot;preTransformBundle&quot;:&quot;&quot;,&quot;postTransformBundle&quot;:&quot;&quot;,&quot;sendJSONPath&quot;:&quot;&quot;,&quot;sendJSONNode&quot;:&quot;&quot;,&quot;responseJSONPath&quot;:&quot;&quot;,&quot;responseJSONNode&quot;:&quot;&quot;,&quot;id&quot;:&quot;vlcCart&quot;,&quot;itemsKey&quot;:&quot;cartItems&quot;,&quot;modalConfigurationSetting&quot;:{&quot;modalHTMLTemplateId&quot;:&quot;vlcProductConfig.html&quot;,&quot;modalController&quot;:&quot;ModalProductCtrl&quot;,&quot;modalSize&quot;:&quot;lg&quot;}},{&quot;render&quot;:false,&quot;dispOutsideOmni&quot;:false,&quot;label&quot;:&quot;&quot;,&quot;remoteClass&quot;:&quot;&quot;,&quot;remoteMethod&quot;:&quot;&quot;,&quot;remoteTimeout&quot;:30000,&quot;remoteOptions&quot;:{&quot;preTransformBundle&quot;:&quot;&quot;,&quot;postTransformBundle&quot;:&quot;&quot;},&quot;preTransformBundle&quot;:&quot;&quot;,&quot;postTransformBundle&quot;:&quot;&quot;,&quot;id&quot;:&quot;vlcKnowledge&quot;,&quot;itemsKey&quot;:&quot;knowledgeItems&quot;,&quot;modalConfigurationSetting&quot;:{&quot;modalHTMLTemplateId&quot;:&quot;&quot;,&quot;modalController&quot;:&quot;&quot;,&quot;modalSize&quot;:&quot;lg&quot;}}],&quot;allowSaveForLater&quot;:true,&quot;saveNameTemplate&quot;:null,&quot;saveExpireInDays&quot;:null,&quot;saveForLaterRedirectPageName&quot;:&quot;sflRedirect&quot;,&quot;saveForLaterRedirectTemplateUrl&quot;:&quot;vlcSaveForLaterAcknowledge.html&quot;,&quot;saveContentEncoded&quot;:false,&quot;saveObjectId&quot;:&quot;%ContextId%&quot;,&quot;saveURLPatterns&quot;:{},&quot;autoSaveOnStepNext&quot;:false,&quot;elementTypeToHTMLTemplateMapping&quot;:{},&quot;seedDataJSON&quot;:{},&quot;trackingCustomData&quot;:{},&quot;enableKnowledge&quot;:false,&quot;bLK&quot;:false,&quot;lkObjName&quot;:null,&quot;knowledgeArticleTypeQueryFieldsMap&quot;:{},&quot;timeTracking&quot;:false,&quot;hideStepChart&quot;:true,&quot;mergeSavedData&quot;:false,&quot;visualforcePagesAvailableInPreview&quot;:{},&quot;cancelType&quot;:&quot;SObject&quot;,&quot;allowCancel&quot;:true,&quot;cancelSource&quot;:&quot;%ContextId%&quot;,&quot;cancelRedirectPageName&quot;:&quot;OmniScriptCancelled&quot;,&quot;cancelRedirectTemplateUrl&quot;:&quot;vlcCancelled.html&quot;,&quot;consoleTabLabel&quot;:&quot;New&quot;,&quot;wpm&quot;:false,&quot;ssm&quot;:false,&quot;message&quot;:{},&quot;pubsub&quot;:false,&quot;autoFocus&quot;:false,&quot;currencyCode&quot;:&quot;&quot;,&quot;showInputWidth&quot;:false,&quot;rtpSeed&quot;:false,&quot;consoleTabTitle&quot;:null,&quot;consoleTabIcon&quot;:&quot;custom:custom18&quot;,&quot;errorMessage&quot;:{&quot;custom&quot;:[]},&quot;stylesheet&quot;:{&quot;newport&quot;:&quot;&quot;,&quot;lightning&quot;:&quot;&quot;,&quot;newportRtl&quot;:&quot;&quot;,&quot;lightningRtl&quot;:&quot;&quot;},&quot;stepChartPlacement&quot;:&quot;right&quot;,&quot;disableUnloadWarn&quot;:true,&quot;scrollBehavior&quot;:&quot;auto&quot;,&quot;currentLanguage&quot;:&quot;en_US&quot;}</propertySetConfig>
    <subType>Sample</subType>
    <type>Reusable</type>
    <uniqueName>Reusable_Sample_English_1</uniqueName>
    <versionNumber>1.0</versionNumber>
    <webComponentKey>74c6e411-a174-1fa7-e2df-465bba8300e5</webComponentKey>
</OmniScript>
