({
    convert : function(component) {
        
    
        let a = window.SpeechRecognition;
        console.log('a',a);
        console.log('In Helper');
        
        let state, action, ret, opts = [], priceValues = [],
        unformatobj;

        action = component.get('c.calloutCurrency');
        action.setCallback(this, function(response) {
            state = response.getState();
            if (state === "SUCCESS") {
                console.log("In callOutCurrency")
                ret = response.getReturnValue();
                ret = JSON.parse(ret);

                unformatobj = ret['quotes'];
                console.log('unformatobj: '+unformatobj+' JSON Stringify '+JSON.stringify(unformatobj));
                Object.keys(unformatobj).map(val => {
                    opts.push({
                        'label': val.slice(3),
                        'value': unformatobj[val].toFixed(2)
                    });
                    console.log('unformatobj: '+val, unformatobj[val]);
                    if (val == 'USDCAD') {
                        component.set("v.cadPrice", unformatobj[val].toFixed(2));
                    }
                    if (val == 'USDEUR') {
                        component.set("v.eurPrice", unformatobj[val].toFixed(2));
                    }
                })
                
            }
            console.log('opts', opts);
            opts.push({
                'label': 'USD',
                'value': 1,
                'selected' : true
            });
            component.set('v.options', opts);
        });
        $A.enqueueAction(action);
   
    }
})