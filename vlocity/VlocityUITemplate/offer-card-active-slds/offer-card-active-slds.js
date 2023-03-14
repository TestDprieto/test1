vlocity.cardframework.registerModule
    .controller('viaOfferCardActive',
                    ['$scope', '$rootScope', 'interactionTracking',
                        function($scope, $rootScope, interactionTracking) {


        var lightningNsPrefix = $scope.nsPrefix.replace('__', ':'),
            collectedChanges = [];

        this.getImageUrl = function(obj) {
            if (!obj) {
                return null;
            }
            var imageId = null;
            Object.keys(obj.attachment).forEach(function(key) {
                if (!imageId) {
                    imageId = obj.attachment[key];
                }
                if (/@sidebar/.test(key)) {
                    imageId = obj.attachment[key];
                    return false;
                }
            });
            return ($rootScope.instanceUrl  || '') + '/servlet/servlet.FileDownload?file=' +imageId;
        };

        this.getTags = function(obj) {
            if (!obj || !angular.isArray(obj.componentScores)) {
                return [];
            }
            return obj.componentScores.reduce(function(array, componentScore) {
                if (componentScore && angular.isArray(componentScore.scoreParameters)) {
                    return array.concat(componentScore.scoreParameters);
                }
                return array;
            }, []);
        };

        this.dismissOffer = function(obj, card, $event) {
            var interactionData = interactionTracking.getDefaultTrackingData($scope);
            var eventData = {
                'TrackingService': 'Acuity',
                'TrackingEvent' : 'Reject',
                'ContextId' : obj.contextId,
                'ResourceId' : obj.resourceId,
                'ScaledRawScore' : obj.scaledRawScore,
                'CurrentMachine' : obj.currentMachine,
                'TargetObjectType' : obj.targetObjectType,
                'TargetObjectKey' : obj.targetObjectKey
            };
            interactionData = angular.extend(interactionData, eventData);
            interactionTracking.addInteraction(interactionData);
            $event.stopPropagation();
            $scope.$emit($scope.data.layoutName+'.events', {
                event: 'removeCard',
                message: $scope
            });
        };

        $scope.$on('$destroy', removeHandlers);

        function removeHandlers(justRemoveLightning) {
            if (typeof $A !== 'undefined') {
                $A.eventService.removeHandler({
                    "event": lightningNsPrefix + "profileAttributeValueUpdatedEvent",
                    "handler": profileAttributeValueUpdatedEventHandler,
                    "globalId": $scope.layoutName + "-profileAttributeValueUpdatedEvent"
                });
                $A.eventService.removeHandler({
                    "event": lightningNsPrefix + "profileAttributeCategoryUpdatedEvent",
                    "handler": profileAttributeCategoryUpdatedEventHandler,
                    "globalId": $scope.layoutName + "-profileAttributeCategoryUpdatedEvent"
                });
                $A.eventService.removeHandler({
                    "event": lightningNsPrefix + "profileNavigationEvent",
                    "handler": profileNavigationEventHandler,
                    "globalId": $scope.layoutName + "-profileNavigationEvent"
                });
            }
            if (window.sforce && sforce.console && justRemoveLightning !== true) {
                sforce.console.removeEventListener('refreshActivityLog',  profileAttributeValueUpdatedEventHandler);
            }
        }

        function profileNavigationEventHandler(event) {
            var navigateFrom = event.getParam('navigateFrom'),
                navigateTo = event.getParam('navigateTo');
            if (navigateFrom === 'slide-to-profiler-edit' && collectedChanges.length > 0) {
                $scope.bypassTemplateRefresh = true;
                $rootScope.$broadcast($scope.data.layoutName+'.events', {
                    event: 'reload',
                    message: []
                });
            } else {
                collectedChanges = [];
            }
        }

        function profileAttributeCategoryUpdatedEventHandler(event) {
            collectedChanges.push(event);
        }

        function profileAttributeValueUpdatedEventHandler(event) {
            $scope.bypassTemplateRefresh = true;
            $rootScope.$broadcast($scope.data.layoutName+'.events', {
                event: 'reload',
                message: []
            });
        }

        function registerLightningEventHandler() {
            if (window.sforce && sforce.console) {
                sforce.console.removeEventListener('refreshActivityLog',  profileAttributeValueUpdatedEventHandler);
                sforce.console.addEventListener('refreshActivityLog',  profileAttributeValueUpdatedEventHandler);
            }
            if (typeof $A === 'undefined') {
                setTimeout(registerLightningEventHandler, 1000);
                return;
            }
            // only register one set
            removeHandlers(true);
            $A.eventService.addHandler({
                "event": lightningNsPrefix + "profileAttributeValueUpdatedEvent",
                "handler": profileAttributeValueUpdatedEventHandler,
                "globalId": $scope.layoutName + "-profileAttributeValueUpdatedEvent"
            });

            $A.eventService.addHandler({
                "event": lightningNsPrefix + "profileAttributeCategoryUpdatedEvent",
                "handler": profileAttributeCategoryUpdatedEventHandler,
                "globalId": $scope.layoutName + "-profileAttributeCategoryUpdatedEvent"
            });
            
            $A.eventService.addHandler({
                "event": lightningNsPrefix + "profileNavigationEvent",
                "handler": profileNavigationEventHandler,
                "globalId": $scope.layoutName + "-profileNavigationEvent"
            });
        }

        registerLightningEventHandler();

    }]);