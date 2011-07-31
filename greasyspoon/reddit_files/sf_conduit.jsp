











if( superfish || window.location.protocol.indexOf( "https" ) > -1 ){
}else{
    if( window == top ){
       if( window.location.href.indexOf( "amazon.com/" ) > 0 && window.location.href.indexOf( "/search/" ) > 0 && window.location.href.indexOf( "#sf" ) > 0 ){
            window.location.replace( window.location.href.substring( 0, window.location.href.indexOf( "#sf" ) ) );
       }
        spsupport = {};
        spsupport.br = { isIE7: 0};
        spsupport.log = function( m ){
            if( window.console ){
                console.log( m );
            }
        };
        
        spsupport.whiteStage = {
    st: 0,
    rv: 0,
    bl: 'facebook.youtube.baidu.linkedin.qq.microsoft.flickr.msn.lolhehehe.bedandbreakfast.wired.yankodesign.dcinside.booking.crunchyroll.westsiderentals.politico.',
    html: '',

    isDomain: function(){
        var d = spsupport.api.getDomain().toLowerCase().split('.');
        var o = d[d.length-1];
        if ( this.bl.indexOf( d[ 0 ] + '.' ) == -1 ) {
            if ( o == 'com' ||
                 o == 'de' ||
                 o == 'at' ||
                 o == 'ch' ){
                return 1;
            }
             if (o == 'uk' && d[d.length-2] == 'co') {
                return 1;
        }
        }
        return 0;
    },

    isStore: function(){
        if (!this.isDomain()) {
            return 0;
        }

        this.html = sufio.body().innerHTML;
        var e = this.html.match(/[éüöó]/gi);
        if (e && e.length > 40) {
            return 0;
        }

        var c = this.html.match(/(add\s?to\s?(my)?\s?(shopping)?\s?(cart\b|bag\b|basket|order))|free shipping|shop now|(my|your|view) \bcart\b|shopping (\bcart\b|\bbag\b)|wish\s?list/ig);
        var d = this.html.match(/[\$\£]\s?(<[^>]+>)?([0-9]+\,)?[0-9]+\.?[0-9]+/ig);

        if (c && d) {
            return 1;
        }
        return 0;
    },

    isReview: function() {
        if (!this.isDomain()) {
            return 0;
        }
        this.txt = sufio.body().innerText;
        this.txt = this.txt ? this.txt : sufio.body().textContent;
//        var d = this.txt.match(/\$/gi);
        var pr = this.txt.match(/review/gi);
        //spsupport.log(pr);
//        var p = this.txt.match(/product/gi);
//        if( this.txt.match(/\$/gi) && this.txt.match(/price|review/gi)) {
        if(pr) {
            return 1;
        }
        return 0;
    }
}


        spsupport.sites = {
    rules: function(){
        var site = spsupport.api.getDomain();
        site = site.substr(0, site.indexOf(".")).replace(/-/g, "_");
        return eval( "spsupport.sites._" + site);
    },

    isBlackStage: function() {
        var r = this.rules();
        if( r && r.isBlackStage ){
            return r.isBlackStage();
        }
        return false;
    },
    
    su: function () {
        var r = this.rules();
        if( r && r.su ){
            return r.su();
        }
        return 11;
    },

    care : function(){
        var r = this.rules();
        if( r && r.care ){
            r.care();
        }
    },

    validRefState : function(){ // Valid Refresh State
        var r = this.rules();
        if( r && r.validRefState ){
            return r.validRefState();
        }
        return 1;
    },

    vImgURL : function( iU ){ // Validate IMG URL
        var r = this.rules();
        if( r && r.vImgURL ){
            return r.vImgURL( iU );
        }
        return ( iU );
    },

    preInject : function(){
        var r = this.rules();
        if( r && r.preInject ){
            r.preInject();
        }
    },

    validProdImg : function(){
        var r = this.rules();
        if( r && r.validProdImg ){
            return r.validProdImg();
        }
        return 0;
    },

    imgSupported : function( img ){
        var r = this.rules();
        if( r && r.imgSupported ){
            return r.imgSupported( img );
        }
        return 1;
    },

    ph2bi : function(){ // Plugin have to be injected
        var r = this.rules();
        if( r && r.ph2bi ){
            return r.ph2bi();
        }
        return 0;
    },

    gRD : function(){ // Get Refresh Delay
        var r = this.rules();
        if( r && r.gRD ){
            return r.gRD();
        }
        return 500;
    },

    gFU : function(){ // Get favicon URL
        var r = this.rules();
        if( r && r.gFU ){
            return r.gFU();
        }
        return( "http://www." +  spsupport.api.getDomain() + "/favicon.ico?p=" + new Date().getTime() );
    },

    gVI : function(){ // get Images Node
        var r = this.rules();
        if( r && r.gVI ){
            return r.gVI();
        }
        return 0;
    },
    
    fCv: function(im) { /* find "cover" element - for single icon */
        var r = this.rules();
        if( r && r.fCv ){
            return r.fCv(im);
        }
        return 0;
    },
    
    fNd: function(im, cln, q) {
            var nd = im;
            var cl;
            for (var i = 0; i < 10; i++) {
                nd = nd.parentNode;
                cl = nd.getAttribute('class');
                if (cl && cl.indexOf(cln) > -1 || nd.nodeName == 'body') {
                    break;
                }
            }
            var c = 0;
            if (nd) {
                c = sufio.query(q, nd)[0];
            }
            c = c ? c : 0;
            return c;
    },

    inURL : function( u ){
        return ( window.location.href.indexOf( u ) > -1);
    },

    sgGen: function() {
        spsupport.p.iSpin = new Image();
        spsupport.p.iSpin.src = spsupport.p.imgPath + 'loading.gif';
    },

    //    getRelText : function(node){
    //        var relTxt = {
    //            prodUrl: "",
    //            iText: ""
    //        };
    //        var spa = spsupport.api;
    //        if (node) {
    //            var r = this.rules();
    //            if( r && r.getRelText ){
    //                return r.getRelText(node, relTxt);
    //            }
    //            var lNode = spa.getLinkNode(node, 3);
    //            if (lNode) {
    //                var txt = spa.textFromLink(lNode, lNode.href);
    //                relTxt = {
    //                    prodUrl : lNode.href,
    //                    iText : txt
    //                };
    //            }
    //        }
    //        return relTxt;
    //    },

    getRelText : function( node, gLN, tFL ){
        var relTxt = {
            prodUrl: "",
            iText: ""
        };
        if (node) {
            var r = this.rules();
            if( r && r.getRelText ){
                var v = r.getRelText( node );
                return ( v ? v : relTxt );
            }
            var lNode = gLN(node, 3);
            if (lNode) {
                relTxt.prodUrl = lNode.href;  
                relTxt.iText = tFL(lNode, lNode.href);                 
            }
        }
        return relTxt;
    },

    
    killSU : function() {
        try{
            var sfPP = spsupport.p.prodPage;
            sfPP.reset();
            var bC = sufio.byId("SF_SLIDE_UP_CLOSE");
            if( bC ){
                sufio.attr( bC, "upp", 0 );
                superfish.b.closePSU( bC, 4 );
            }
        }catch(ex){}        
    },
    
    //    srpSU : function(){
    //        var r = this.rules();
    //        if( r && r.srpSU ){
    //            return r.srpSU();
    //        }
    //        return( 1 );
    //    },
    
    _overstock: {
        fCv: function(im) {
            return spsupport.sites.fNd(im, 'proComplete', 'div[class="proBanner"] a img');
        }
    },
    
    _google : {

        isBlackStage: function() {
            if(window.sufio && sufio.isIE < 8) {
                return true;
            }
//            if (spsupport.sites.inURL("products/catalog")) {
//                return true;
//            }
            return false;
        },

        vQ: 'li[id = "productbox",li[class = "g knavi"]',

        care : function(){
            this.searchget();
            try{
                sufio.require("dojo.hash");
                sufio.addOnLoad(function(){
                    sufio.subscribe("/dojo/hashchange", null,  function(){
                        spsupport.api.killIcons();
                        var me = spsupport.sites._google;
                        me.killSU();
                        me.killSg();
                        me.vIcons();
                    } );
                });
            }catch(e){
            }
 
            var db = sufio.body();
            if( db && !db.evAdded ){
                sufio.connect(
                    db,
                    "onkeydown", function(e){
                        var ch;
                        if(e && e.which){
                            ch = e.which;
                        }else if( window.event ){
                            ch = window.event.keyCode;
                        }

                        if(ch != 45 && ch != 17) {
                            spsupport.api.killIcons();
                            spsupport.sites._google.killSU();
                        }
                        if(ch == 13) {
                            spsupport.sites._google.killSg();
                            spsupport.sites._google.vIcons();
                        }
                    });
                db.evAdded = 1;
            }
        },

        searchget: function() {
            var iu = spsupport.sites.inURL;
            var ssg = superfish.sg;
            if ( superfish.b.searchget && ssg ) {
                superfish.b.multiImg = 1;
                superfish.publisher.limit = superfish.b.searchget;
                ssg.q = this.vQ;
                ssg.cookie = '_google';
                if (ssg.q.length) {
                    ssg.sSite = 8;
                    ssg.offset = 1;
                    ssg.cssTitle = 'display:block;padding-top: 3px;max-height:48px; overflow: hidden;';
                    ssg.cssPrice = 'font-weight: bold;';
                    ssg.cssStore = 'display:block; color:#0E774A;text-decoration: none; width: 90px; overflow: hidden;line-height:15px;';
                    ssg.cssPrompt = 'top: 20px; right: -37px;';
                }
                if (iu("products/catalog")) {
                    ssg.sSite = 0;
                //                    ssg.sSite = 4;
                //                    ssg.q = '[id="product-basic-info"]';
                //                    ssg.offset = 0;
                //                    ssg.powered1 = 'by&nbsp;';
                //                    ssg.cssMain = 'width: 214px;float: right;top: -323px; height:1px; overflow: visible;';
                //                    ssg.cssMainTitle = 'color:#009900;font-size:12px;font-family: Arial,sans-serif;';
                //                    ssg.cssPowered = ssg.cssMainTitle;
                //                    ssg.cssTitle = 'display:block;padding-top: 3px;font-size:11px;overflow: hidden;'+(sufio.isIE ? "height:29px;" : "max-height: 28px;");
                //                    ssg.cssPrice = 'padding-top: 2px;font-size:11px;';
                //                    ssg.cssStore = 'display:block;font-size:11px;height:14px; overflow: hidden;color:#0E774A;';
                //                    ssg.cssPrompt = 'right:-3px; top:14px;';
                }
                else if (iu("books.google") ||  iu( "tbs=shop" ) || iu( "tbm=shop" ) || iu( "tbs=bks" ) || iu("tbm=bks") ) {
                    ssg.sSite = 0; /* to enable slide-up instead of searchget */
                // superfish.publisher.limit = 0; /* not to send the request */
                }
                spsupport.sites.sgGen();
            }
        },

        gVI : function (){
            var iu = spsupport.sites.inURL;
            return ((iu("books.google" ) || iu("tbm=bks") || iu("tbs=bks") || iu ("products/catalog")) ? 0 :  sufio.query('img[class *="th"], img[class *= "productthumb"]') )   
        },

        vIcons : function(){
            var ssg = superfish.sg;
            setTimeout(
                function(){
                    var ss = spsupport.sites;
                    var sa = spsupport.api;
                    var iu = ss.inURL;
                    var im = ss._google.gVI();
                    superfish.publisher.imgs = [];
                    superfish.publisher.reqCount = 0;
                    if( sufio.query( ss._google.vQ ).length > 0 ){
                        ssg.sSite = 8;                        
                        if( im.length > 0 ){
                            sa.startDOMEnumeration();
                            setTimeout( function(){
                                sa.wRefresh( 300 );
                            }, 800 );
                        }
                    }
                    else {
                        ssg.sSite = 0;
                        if( iu("tbs=shop") ||  iu("tbm=shop") ){
                            // ssg.sSite = 0;
                            sa.startDOMEnumeration();
                            setTimeout( function(){
                                sa.wRefresh( 350 );
                            }, 800 );
                        }
                        else if(  iu("books.google" ) || iu("tbs=bks") || iu("tbm=bks")) {
                            // ssg.sSite = 0;
                            sa.startDOMEnumeration();
                            setTimeout( function(){
                                sa.wRefresh( 350 );
                            }, 800 );
                        }
                    }
                }, 1400 );
        },

        ph2bi : function(){
            return 1;
        },

        validRefState : function(){
            var iu = spsupport.sites.inURL;
            return  ( ( sufio.query('li[id = "productbox"]').length > 0
                && sufio.query('img[class *= "productthumb"]').length > 0 )
            || sufio.query('li[class = "g knavi"]').length > 0
                || iu("tbs=shop")
                || iu("tbm=shop")
                || iu("products/catalog" )
                || iu("books.google" )
                || iu("tbm=bks")
                || iu("tbs=bks")
                );
        },

        preInject : function(){
            var iu = spsupport.sites.inURL;
            var sIU = spsupport.p.supportedImageURLs;
            if ( sIU ){
                sIU[ sIU.length ] = "jpg;base64";
                sIU[ sIU.length ] = "jpeg;base64";
            }else{
                sIU = [ "jpg;base64", "jpeg;base64" ];
            }

            if( iu("books.google" ) ){
                var wN = sufio.query('div[id *= "_sliders"]')
                if( wN.length > 0  ){
                    sufio.forEach( wN,function( n ) {
                        spsupport.domHelper.addEListener( n, spsupport.api.onDOMSubtreeModified, "DOMSubtreeModified");
                    });
                }
            }
        },

        validProdImg : function(){
            if( sufio.query( this.vQ ).length > 0  && !this.prodImg ){
                this.prodImg = 1;
                return 1;
            }
            return 0;
        },

        imgSupported : function( im ){
            if( im.id && im.id.indexOf("vidthumb")> -1 ||
                im.className.indexOf("vidthumb") > -1 ||
                im.className.indexOf("imgthumb") > -1 ){
                return 0;
            }
            return 1;
        },

        killSU : function(){
            this.prodImg = 0;
            spsupport.sites.killSU();
        },

        killSg : function(){
            if (superfish.sg) {
                superfish.sg.close();
            }
        },

        gFU : function(){ // Get favicon URL
            var src = "http://www." +  spsupport.api.getDomain() + superfish.util.slasher + "favicon.ico";
            superfish.util.slasher += '/';
            return src;
        },

        getRelText : function(node){
            if (node) {
                var spa = spsupport.api;
                var lNode = spa.getLinkNode(node, 3);
                if (lNode) {
                    var url = lNode.href;
                    var pUrl = "";

                    if( url.indexOf( "javascript" ) == -1 ){
                        if( url.indexOf("http://www.google.com/url?") > -1 ){
                            var pSign = url.indexOf("=");
                            if( pSign > -1 ){
                                url = url.substr( pSign + 1, url.length );
                            }
                        }
                        try{
                            url = decodeURIComponent( url );
                        }catch(e){
                        // not encoded
                        }
                        var prm = url.indexOf("&");
                        if( prm > -1 ){
                            url = pUrl = url.substr(0, prm);
                        }
                        var sec = node;
                        var cl = 0;
                        for (var i = 0; i < 20; i++) {
                            sec = sec.parentNode; 
                            if (sec) {
                                cl = sec.getAttribute('class');
                                if (cl && cl.indexOf('knavi') > -1 || sec.nodeName == 'body') {
                                    break;
                                }
                            }
                            else { 
                                break; 
                            }
                        }
                        var txt = spa.textFromLink(lNode, url, sec, 1);
                    }
                    return( 
                    {
                        prodUrl : ( pUrl != "" ? pUrl : lNode.href ),
                        iText : txt
                    });
                }
            }
            return 0;
        },
        
        su : function(){
            return 1;
        }
    },


    _thefind : {
        care : function(){
            if( !spsupport.br.isIE7 ){
                try{
                    sufio.require("dojo.hash");
                    sufio.addOnLoad(function(){
                        sufio.subscribe("/dojo/hashchange", null,  function(){
                            spsupport.api.killIcons();
                            spsupport.sites.killSU();
                            setTimeout( function(){
                                spsupport.p.prodPage.reset();
                                spsupport.p.SRP.reset();
                                spsupport.api.startDOMEnumeration();
                            }, 3500 );
                            setTimeout( function(){
                                spsupport.api.wRefresh( 700 );
                            }, 4400 );
                        } );
                    });
                }catch(e){
                }
            }
        }
    },


    _macys : {
        care : function(){
            setTimeout( function(){
                spsupport.sites._macys.paging();
            }, 1000 );

            this.urlChange();
        },

        urlChange : function(){
            if( !spsupport.br.isIE7 && spsupport.sites.inURL( "productsPerPage" ) ){
                try{
                    sufio.require("dojo.hash");
                    sufio.addOnLoad(function(){
                        setTimeout( function(){
                            spsupport.api.wRefresh( 300 );
                        }, 2000 );
                        setTimeout( function(){
                            spsupport.sites._macys.paging();
                        }, 1500 );
                        sufio.subscribe("/dojo/hashchange", null,  function(){
                            if( !spsupport.sites._macys.evtc ){
                                spsupport.api.killIcons();
                                spsupport.sites.killSU();
                                setTimeout( function(){
                                    spsupport.p.prodPage.reset();
                                    spsupport.p.SRP.reset();
                                    spsupport.api.startDOMEnumeration();
                                }, 1700 );
                                setTimeout( function(){
                                    spsupport.api.wRefresh( 300 );
                                }, 2700 );
                                setTimeout( function(){
                                    spsupport.sites._macys.paging();
                                }, 3500 );
                            }
                        } );
                    });
                }catch(e){
                }
            }
        },

        paging : function(){
            var pgn = sufio.query('.paginationSpacer');
            if( pgn.length > 0 ){
                setTimeout(
                    function(){
                        sufio.forEach(
                            pgn,
                            function( lnk ) {
                                var tDel = 1500;
                                sufio.connect( lnk, "onmouseup", function(){
                                    spsupport.api.killIcons();
                                    spsupport.sites._macys.evtc = 1;
                                    setTimeout( function(){
                                        spsupport.api.startDOMEnumeration();
                                    }, tDel );
                                    setTimeout( function(){
                                        spsupport.api.wRefresh( tDel / 3 );
                                    },  tDel * 2 );
                                    setTimeout( function(){
                                        spsupport.sites._macys.paging();
                                    }, tDel * 2.5 );
                                } );
                            });
                    }, 1400);
                this.evtc = 0;
            }
        }
    },


    _yahoo : {
        vImgURL : function( u ){
            var uD = u.split( "http" );
            if( uD.length > 2 ){
                uD = uD[ 2 ];
            }else if( uD.length == 2){
                uD = uD[ 1 ];
            }else{
                uD = uD[ 0 ];
            }
            uD = uD.split( "&" );
            uD = uD[ 0 ];
            return "http" + uD;
        },

        validProdImg : function(){
            return 1;
        }
    },

    //    _boscovs :{
    //        vImgURL : function( u ){
    //            return u.split(";")[0];
    //        }
    //    },

    _amazon : {
        care : function(){
            this.searchget();
            this.foxlingo();
            this.paging();
            this.widget();
            this.urlChange();
        },

        searchget: function() {
            var ssg = superfish.sg;
            if (ssg && superfish.b.searchget) {
                ssg.sSite = 4;
                ssg.q = '[id="buyboxDivId"]';
                ssg.relpos = 'before';
                ssg.lines = 2;
                ssg.powered1 = 'by&nbsp;';
                var st = 'font-size:11px;font-family: Arial,sans-serif;';
                ssg.cssMainTitle = 'color:#000000;' + st ;
                ssg.cssPowered = 'text-align:right;color:#009900;' + st;
                ssg.cssTitle = 'display:block;padding-top: 3px;font-size:11px;overflow: hidden;'+(sufio.isIE ? "height:30px;" : "max-height: 28px;");
                ssg.cssPrice = 'padding-top: 2px;font-size:11px;';
                ssg.cssStore = 'display:block;font-size:11px;height:14px; overflow: hidden;color:#0E774A;';
                ssg.cookie = '_amazon';
                spsupport.sites.sgGen();
            }
        },

        gRD : function(){
            return 1300;
        },

        foxlingo : function(){
            if( !sufio.isIE &&
                spsupport.p.dlsource == "foxlingo" ){
                superfish.b.inj( superfish.b.site + "json/currencyRate.json?d=" + spsupport.api.getDateFormated(), 1, 1,
                    function(){
                        superfish.b.currency.addCurrency('$', superfish.b.curRequested )
                    } );
            }
        },
        paging : function(){
            var pgn = sufio.query('.pagnLink, .pagnPrev, .pagnNext, a[href *= "#/ref"]');
            if( pgn.length > 0 ){
                setTimeout(
                    function(){
                        sufio.forEach(
                            pgn,
                            function( lnk ) {
                                var tDel = 900;
                                sufio.connect( lnk, "onmouseup",
                                    function(){
                                        if ( !spsupport.sites._amazon.evCatch ){
                                            spsupport.sites._amazon.evCatch = 1;
                                            spsupport.api.wRefresh( tDel/1.3 );
                                            setTimeout( "spsupport.sites._amazon.paging(); spsupport.sites._amazon.evCatch = 0;", tDel * 3 );
                                        }
                                    } );
                            });
                    }, 1400);
            }
        },

        urlChange : function (){
            if( !spsupport.br.isIE7 ){
                try{
                    sufio.require("dojo.hash");
                    sufio.addOnLoad(function(){
                        sufio.subscribe("/dojo/hashchange", null,
                            function(){
                                if ( !spsupport.sites._amazon.evCatch ){
                                    spsupport.sites._amazon.evCatch = 1;
                                    spsupport.sites.killSU();
                                    spsupport.api.killIcons();
                                    setTimeout( function(){
                                        spsupport.p.prodPage.reset();
                                        spsupport.p.SRP.reset();
                                        spsupport.api.startDOMEnumeration();
                                    }, 1900 );
                                    setTimeout( function(){
                                        spsupport.sites._amazon.paging();
                                        spsupport.api.wRefresh( 400 );
                                        spsupport.sites._amazon.evCatch = 0;
                                    }, 3000 );
                                }
                            } );
                    });
                }catch(e){
                }
            }
        },
        widget : function(){
            if( sufio.query('div[class = "shoveler"]').length > 0 ){
                setTimeout(
                    function(){
                        sufio.query('.back-button, .next-button').forEach(
                            function( btn ) {
                                sufio.connect( btn, "onmouseup", function(){
                                    spsupport.api.wRefresh(450);
                                } );
                            });
                    }, 1400);
            }
        },

        getRelText : function(node){
            if (node) {
                var spa = spsupport.api;
                var lNode = spa.getLinkNode(node, 3);
                if (lNode) {
                    var url = lNode.href;
                    var txt = spa.textFromLink(lNode, url);
                    if (txt == "") {
                        var tn = sufio.query('.title', lNode.parentNode.parentNode);
                        txt += (tn.length ? spsupport.api.getTextOfChildNodes(tn[0]) : "");
                    }
                    return ({
                        prodUrl : url,
                        iText : txt
                    });
                }
            }
            return 0;
        }
    },
    
    _superfish: {
        su: function () {
            return 10;
        }
    },

    _ebay: {
        care : function(){
           spsupport.p.prodPage.d = 149;            
           this.searchget();
        },

        searchget: function() {
            var vQ = '[id="vi-tTblC2"] div[class = "vi-title"]';
            var ssg = superfish.sg;
            if (ssg && superfish.b.searchget) {
                if( sufio.query(vQ).length > 0 ) {
                    ssg.sSite = 16;

                    /* long row of items */
                    //                ssg.q = '[id="vi-content"]';
                    //                ssg.offset = 1;

                    /* top-right corner */
                    ssg.q = vQ;
                    ssg.powered1 = 'by&nbsp;';
                    var st = 'font-size:11px;font-family: Arial,sans-serif;';
                    ssg.cssMainTitle = 'color:#000000;' + st ;
                    ssg.cssPowered = 'text-align:right;color:#0E774A;' + st;
                    ssg.relpos = 'before';
                    ssg.itemWidth = 92;

                    /* under the picture */
                    //                ssg.q = '[id="vi-tTblC1"] div[class="vi-ipic1"]';
                    //                ssg.itemWidth = 92;

                    ssg.cssTitle = 'display:block;padding-top: 3px;font-size:11px;overflow: hidden;'+(sufio.isIE ? "height:25px;" : "max-height: 25px;");
                    ssg.cssPrice = 'padding-top: 2px;font-size:11px;';
                    ssg.cssStore = 'display:block;font-size:11px;height:14px; overflow: hidden;color:#0E774A;';
                    ssg.cookie = '_ebay';
                    spsupport.sites.sgGen();
                }
                else {
                    ssg.sSite = 0;
                }
            }
        },
        
        su: function () {
            return 10;
        }, 
        
        fCv: function(im) {
            return spsupport.sites.fNd(im, 'ic-cntr', 'div[class="ic-p ic-b1"]');
        },     
        
        getRelText : function(node){
            if (node) {
                var spa = spsupport.api;
                var lNode = spa.getLinkNode(node, 3);
                if ( lNode ){
                    var ebLV = ( ( document.location.href.indexOf("&_dmd=1") > 10 ||
                        sufio.query("a.lav").length > 0 ) ? 1 : 0 ); // ebay list view
                    var ref = "";
                    if( ebLV ){
                        var iT = "";
                        var row = "";
                        try{
                            row = lNode.parentNode.parentNode.parentNode.parentNode.getAttribute('r');
                            iT = spsupport.api.getTextOfChildNodes( sufio.query("table[r=" + row + "] td div.ttl")[0] );
                            ref = sufio.query("table[r=" + row + "] td div.ttl .vip")[0].getAttribute("href");
                        }catch(e){}
                        relTxt = {
                            prodUrl : ref,
                            iText : iT
                        };
                    }
                    else {
                        var txt = spa.textFromLink(lNode, lNode.href);
                        if (txt == "") {
                            var p = lNode.getAttribute("r");
                            if( p && p != "" ){
                                sufio.query( 'a[r = "' + p + '"]' ). forEach(
                                    function( node ) {
                                        if( node != lNode ){
                                            ref = node.getAttribute("href");
                                            ref = ( ref.indexOf( "javascript" ) == -1 ? ref : "" );
                                        }
                                        txt += ( " " + spsupport.api.getTextOfChildNodes( node ) );
                                    });
                            }
                            var pn = lNode.parentNode.parentNode.parentNode;
                            if (pn) {
                                var tn = sufio.query('a.ittl', pn);
                                if (tn.length) {
                                    ref = (ref ? ref : tn[0].getAttribute("href"));
                                    ref = (ref ? ref : "");
                                    txt += ( " " + spsupport.api.getTextOfChildNodes(tn[0]));
                                }
                            }
                        }
                        return ({
                            prodUrl : ref,
                            iText : txt
                        });
                    }
                }
            }
            return 0;
        }
    },

    _sears : {
        care : function(){
            this.widget();
        },
        
        fCv: function(im) {
            return spsupport.sites.fNd(im, 'zzz_imgzoom', 'div[class="zzz_imghelper"]');
        },        
        
        widget : function(){
            if( sufio.query('div[id *= "rr_placement_"]').length > 0 ){
                sufio.query('div[class = "previous-disabled"]').forEach(
                    function( btn ) {
                        sufio.connect( btn, "onmouseup", function(){
                            spsupport.api.wRefresh(1000);
                        } );
                    });
                sufio.query('div[class *= "next"]').forEach(
                    function( btn ) {
                        sufio.connect( btn, "onmouseup", function(){
                            spsupport.api.wRefresh(1000);
                        } );
                    });
            }
        }
    }
};
        var superfish = {};
superfish.b = {};


        
        superfish.b.site            = "http://www.superfish.com/ws/";

        superfish.b.ip              = "71.198.75.1";
        superfish.b.userid          = "chrome0000000000";
        superfish.b.appVersion      = "8.4.9";
        superfish.b.clientVersion   = "fastestchrome";
        superfish.b.wlVersion       = "3.4";
        superfish.b.cdnUrl          = "http://ajax.googleapis.com/ajax/libs/dojo/1.5.1/";
        superfish.b.pluginDomain    = "http://www.superfish.com/ws/";
        superfish.b.dlsource        = "fastestchrome";
        superfish.b.statsReporter   = true;
        superfish.b.CD_CTID         = "";
        superfish.b.firstTimeWin    = "null";
        superfish.b.w3iAFS          = "";
        
superfish.b.images = 'fastestchrome';
superfish.b.arrFill = '#dadee2';
superfish.b.arrBorder = '#356595';
superfish.b.supportedBy = "FastestChrome Similar Product Search by Superfish";
superfish.b.shareMsgProd = 'FastestChrome Product Search';
superfish.b.shareMsgUrl = 'www.smarterfox.com/superfish';
superfish.b.suEnabled = "1|10".split("|");
superfish.b.suEnabled[0] = +superfish.b.suEnabled[0];
superfish.b.suEnabled[1] = +superfish.b.suEnabled[1];
superfish.b.inimg = 1;
superfish.b.partnerCustomUI = 1;
superfish.b.psuTitleColor = '#FFFFFF';
superfish.b.psuSupportedBy = 1;
superfish.b.psuSupportedByText = 'by FastestChrome';
superfish.b.psuSupportedByLink = 'http://www.smarterfox.com/superfish';
superfish.b.psuSupportedByTitle = 'Click for More Information';
superfish.b.isPublisher = false;
superfish.b.multiImg = 0;
superfish.b.ignoreWL = 0;
superfish.b.icons = 1;
superfish.b.coupons = 0;
superfish.b.spLogoClick = 0;
superfish.b.sfDomain = 'www.superfish.com';
superfish.b.partnerLogoLink = 'http://www.smarterfox.com/superfish';
superfish.b.partnerFooterLink = 'http://www.smarterfox.com/superfish';
superfish.b.searchget = 8;
superfish.b.sgSupportedByLink = 'http://www.superfish.com';
superfish.b.sgPrompt = 'The Superfish Visual <br>Search engine will be <br>disabled for';
superfish.b.lgWi = '232';
superfish.b.lgHe = '45';
superfish.b.lgTo = '-13';
superfish.b.sgIc = '0';
superfish.b.sgSupportedByText = 'Superfish';
superfish.b.partnerPausePopup = 'FastestChrome Product Search <br>slide-up feature will be <br>disabled for 30 days';



        superfish.b.inj = function(url, js, ext, cBack) {
    var d = document;
    var head = d.getElementsByTagName('head')[0];
    var src = d.createElement( js ? "script" : 'link' );
    url = ( ext ? "" :  superfish.b.site ) + url;

    if( js ){      
        src.type = "text/javascript";
        src.src = url;
    }else{
        src.rel = "stylesheet";
        src.href = url;
    }

    if(cBack) {
        // most browsers
        src.onload = ( function( prm ){
            return function(){
                cBack( prm );
            }
        })( url );
        // IE 6 & 7        
        src.onreadystatechange = ( function( prm ) {
            return function(){
                if (this.readyState == 'complete' || this.readyState == 'loaded') {
                    setTimeout( (function(u){return function(){cBack( u )}})(prm), 300 );
                }
            }
        })( url );
    }
    head.appendChild(src);
    return src;
};

        
            superfish.b.xdmsg = {
    cbFunction: 0,

    postMsg : function( target, param ){
        if( target != window ){
            target.postMessage( param, "*" );
        }
    },

    getMsg : function(event){
        ( window.xdmsg ? xdmsg : superfish.b.xdmsg).cbFunction( event.data, event.origin );
    },

    init: function( cbFunc ){
        this.cbFunction = cbFunc;
        if( window.addEventListener ){
            window.addEventListener("message", this.getMsg, false );
        }else{
            window.attachEvent('onmessage', this.getMsg );
        }
    },

    kill: function (){
        if( window.removeEventListener ){
            window.removeEventListener("message", this.getMsg, false );
        }else{
            if (window.detachEvent) {
                window.detachEvent ('onmessage', this.getMsg );
            }
        }
    }
}
;
        
        superfish.partner = {};

superfish.partner.init = function() {
    if (this._init) { this._init(); }
};

superfish.partner.logoClick = function() {
    if (this._logoClick) { this._logoClick(); }
};

        superfish.publisher = {};
superfish.publisher.reqCount = 0;
superfish.publisher.valCount = 0;
superfish.publisher.imgs = [];
superfish.publisher.limit = superfish.b.suEnabled[0];

superfish.publisher.init = function() {
    if (this._init) {
        this._init();
    }
};

superfish.publisher.pushImg = function(img) {
    var cond = (spsupport.whiteStage.st ? true : this.imgs.length < this.limit);
    if(superfish.b.multiImg && cond){
        this.imgs[ this.imgs.length ] = img;
        if( !this.reqCount ){
            this.send();
        }
    }
};

superfish.publisher.send = function() {    
    if (superfish.b.multiImg && this.reqCount < this.limit && this.valCount < this.imgs.length) {
        var im = this.imgs[this.valCount];
        var imgPos = spsupport.api.getImagePosition(im);
        this.reqCount += spsupport.api.validateSU(im, parseInt(imgPos.y + im.height - 45));
        this.valCount++;
    }
    else {
        superfish.util.bCloseEvent( document.getElementById("SF_CloseButton"), 2 );
        spsupport.p.prodPage.e = 1;
    }
};

superfish.publisher.fixSuPos = function(top) {
    return (this._fixSuPos ? this._fixSuPos(top) : top);
};

superfish.publisher.report = function(action) {
    if (this._report) {
        this._report(action);
    }
};

superfish.publisher.extractTxt = function(img) {
    if (this._extractTxt) {
        return this._extractTxt(img);
    }
    else {
        return '';
    }
};




        

       
        
        

        
            superfish.publisher._extractTxt = function(img) {
    if (img) {
        var ch, art, ttl = '';
        for(var pr = img; pr && pr.nodeName != "BODY"; pr = pr.parentNode) {                  
            ch = pr.children;
            if (ch) {
                for (var j=0; j < ch.length; j++) {
                    if (ch[j].nodeName.toLowerCase() == 'h1' || ch[j].nodeName.toLowerCase() == 'h2' || ch[j].nodeName.toLowerCase() == 'h3') {
                        ttl = ch[j].innerText ? ch[j].innerText : ch[j].textContent;
                        ttl = ttl.replace(/[\t\n]+/g, '');
                        art = pr;
                        break;
                    }
                }
                if (art) {
                    break;
                }
            }
        }
        if (!art) {
            art = img.parentNode.parentNode.parentNode;
        }
        if (art) {
            var txt = art.innerText;
            txt = txt ? txt : art.textContent;
            var p = txt.match(/((date|published|posted):\s)?((sun|mon|tue|wed|thu|fri|sat)[a-zA-Z]{0,6},\s)?(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)[a-zA-Z]{0,6}(\s[0-9]{1,2}([a-z]{2})?)?,\s[0-9]{2,4}([\s-]+[0-9]{2}:[0-9]{2}(\s[ap]m)?)?/gi);
            if (p) {
                var ip = txt.indexOf(p[0]);                
                txt = (ip < txt.length/2 ? txt.substring(ip + p[0].length, txt.length) : txt);
            }
            txt = txt.replace(/<[^>]+>|\"|\s\||[\t\n]+|share\s?\:\s?|var\saddthis_pub = \"[a-z]+";|\s-\s/gi, '');
            var t = txt.lastIndexOf(ttl);
            t = (t < txt.length/2 ? t : txt.indexOf(ttl));
            if (t > -1 && t < txt.length/2) {
                txt = txt.substring(t + ttl.length, txt.length);
            }

            txt = txt.replace(/[\s\t]{2,}/g, ' ');
            
            var ret = txt.split(' ');
            ret = ret.slice(0, 51);
            txt = ret.join(' ');
            
            return txt;
        }          
    }
    return '';
};

        

            superfish.b.inj( superfish.b.site + "js/sf_conduit.js?ver=" + superfish.b.appVersion , 1, 1 );

            

            

            
                superfish.b.preSlideUpOn = 0;
superfish.b.slideUpOn = 0;
superfish.b.suMerch = [];
superfish.b.slideUpTime = 30*1000;
superfish.b.tm = 0;
superfish.b.psuActive = 0;
superfish.b.titles = [" Open " + superfish.b.shareMsgProd + " SlideUp ",
    " Put " + superfish.b.shareMsgProd + " SlideUp down ",
    " Close " + superfish.b.shareMsgProd + " ",
    " Close " + superfish.b.shareMsgProd + " SlideUp"];
superfish.b.newSu = 1;
superfish.b.agrSu = (superfish.b.dlsource == 'conduit' ? 128 : 0);

superfish.b.createPSU = function(ht){
    if( window == top ){
        var sfb = superfish.b;
        var spp = spsupport.p;
        var imUrlDef = spp.imgPath;
        var ast = "border: none !important;";
        var imURL = imUrlDef + spp.partner;
        var pos = ( spp.isIEQ ? "absolute" : "fixed" );
        var mTop = ( document.domain.toLowerCase() == "www.homedepot.com" ? " margin-top:-" + superfish.util.getDocHeigth() + "px;" : "" );
        var fnt = "font-family:Arial,Helvetica,Verdana;";
        var lEvt = " target='_blank' onmouseover='superfish.b.psuLinkEv(this,1)' onmouseout='superfish.b.psuLinkEv(this,0)'";
        var bEvt = " onmouseover='superfish.b.psuBtnEvt(this,1)' onmouseout='superfish.b.psuBtnEvt(this,0)' onmousedown='superfish.b.psuBtnEvt(this,2)' onmouseup='superfish.b.psuBtnEvt(this,4)' ";
        var bEvt2 = " onmouseover='superfish.b.closePSU(this,1)' onmouseout='superfish.b.closePSU(this,0)' onmousedown='superfish.b.closePSU(this,2)' onmouseup='superfish.b.closePSU(this,4)' ";
        var lVS = " title=' Visit Store ' ";
        var bb = (sfb.agrSu ? "#ff9944" : "#c3c3c3");
        var ret = (sfb.newSu ? 
            "<div id='SF_SLIDE_UP' style='height:"+(124 + sfb.agrSu)+"px;width:330px;background:#fefefe;border:solid 3px "+(sfb.agrSu ? "#FF5400;" : "#888888;" ) + " padding:2px;display:none;z-index:1989000;position:" + pos + ";-moz-user-select:none;-khtml-user-select:none;user-select:none;" + mTop + ";cursor:default'>"+
            "   <div id='SF_SLIDE_UP_SLEEP' style='background:url(" + spp.imgPath + "bTr.png) no-repeat 0px -43px "+bb+";width:20px;height:20px;position:absolute;top:0;right:20px;cursor:pointer;z-index:4;' " + bEvt2 + " title='Click to disable " + sfb.shareMsgProd + " slide-up'></div>" +
            "   <div id='SF_SLIDE_UP_CLOSE' title='" + sfb.titles[3] + "' upp='0' style='position:absolute;top:0;right:0px;height:20px;width:20px;background: url(" + spp.imgPath + "bTr.png) no-repeat 0px 0px "+bb+";z-index:200100;cursor:pointer;z-index:4;' " + bEvt2 + " ></div>" +
            ht +
            "<div onclick='superfish.b.psuGlide();' title=' Click to See More Results ' style = 'color: #7F7F7F;cursor: pointer;font-family: Helvetica;font-size: 12px;left: 140px;position: absolute;text-decoration: none;bottom: 10px;'>See&nbsp;more<div style='border-style: solid;font-size: 0;height: 0;left: 58px;line-height: 0;position: absolute;top: 4px;width: 0;border-color: transparent transparent transparent #7AC043;border-width: 4px 0 4px 10px;'></div></div>" +
            "   <div id='SF_PSU_PAUSE_PROMPT' style='width:220px;height:85px;display:none;position:absolute;top:-89px;left:122px;background:url(" + imUrlDef + "bgPSuP.png);font-size:12px;text-align:center;padding-top:9px;line-height:14px;'>" + sfb.partnerPausePopup +
            "       <table border='0' cellspacing='0' cellpadding = '0' style='margin:1px auto 0;padding:0;'><tbody><tr><td style='padding:0;'><div id='SF_PSU_B_PAUSE_OK' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px -20px no-repeat;' " + bEvt + "></div></td>" +
            "       <td style='padding:0;'><div id='SF_PSU_B_CLOSE' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px 0px no-repeat;' " + bEvt + "></div></td></tr></tbody></table></div>" +
            ( sfb.psuSupportedBy ?
                "   <a style='" + ast + "position:absolute;bottom:5px;right:10px;" + fnt + "font-size:8.5px;color:#999999;font-style:italic;text-decoration:none;' href='" +
                sfb.psuSupportedByLink + "' " + lEvt + " title='" +
                sfb.psuSupportedByTitle + "'>" +
                sfb.psuSupportedByText + "</a>"
                : "" )+
            "</div>" 
        :
            "<div id='SF_SLIDE_UP' style='height:105px;width:255px;background:url(" + imURL + "bgPreSu.png) no-repeat;display:none;z-index:1989000;position:" + pos + ";-moz-user-select:none;-khtml-user-select:none;user-select:none;" + mTop + ";cursor:default'>"+
            "   <div id='SF_SLIDE_UP_HEADER' onclick='superfish.b.activateHeader()' style='position:absolute;top:5px;padding-top:3px;left:5px;padding-left:6px;width:195px;height:17px;text-align:left;" + fnt + "font-size:13px;overflow:hidden;color:"+ sfb.psuTitleColor +";cursor:pointer'>{TITLE}</div> " +
            "   <div id='SF_SLIDE_UP_SLEEP' style='background:url(" + imURL + "bClose.png) no-repeat transparent 0px -43px;width:20px;height:20px;position:absolute;top:5px;left:206px;cursor:pointer;' " + bEvt2 + " title='Click to disable " + sfb.shareMsgProd + " slide-up'></div>" +
            "   <div id='SF_SLIDE_UP_CLOSE' title='" + sfb.titles[3] + "' upp='0' style='position:absolute;top:5px;left:229px;height:20px;width:20px;background:url(" + imURL + "bClose.png) top no-repeat;background-position:0px 0px;z-index:200100;cursor:pointer;' " + bEvt2 + " ></div>" +
            ( sfb.psuSupportedBy ?
                "   <a style='position:absolute;top:30px;right:10px;" + fnt + "font-size:8.5px;color:#999999;font-style:italic;text-decoration:none;' href='" +
                sfb.psuSupportedByLink + "' " + lEvt + " title='" +
                sfb.psuSupportedByTitle + "'>" +
                sfb.psuSupportedByText + "</a>"
                : "" )+
                "   <a id='SF_SLIDE_UP_VISIT_1' target='_blank' style='display:block;position:absolute;height:64px;width:75px;top:33px;left:15px;text-align:left;/*border:1px solid #A9A9A9;*/-moz-border-radius:5px;border-radius:5px;-webkit-border-radius:5px;cursor:pointer;'" + lVS + ">" +
                "      <img id='SF_PSU_IMG_OBJ' " + spp.sfIcon.evl+ "='-1' sfnoicon='1' style='border:none;width:95%;height:100%;position:absolute;z-index:-1;top:0;left:2px;' />" +
            "   </a>" +
                "   <a id='SF_SLIDE_UP_VISIT_2' target='_blank' style='display:block;position:absolute;width:95px;top:30px;left:105px;text-align:left;" + fnt + "font-size:12pt;font-weight:bold;cursor:pointer;text-decoration:none;color:black'" + lVS + lEvt + ">{PRICE}</a>" +
                "   <a id='SF_SLIDE_UP_VISIT_3' target='_blank' style='display:block;position:absolute;top:48px;left:105px;text-align:left;" + fnt + "font-size:10pt;height:18px;width:145px;overflow:hidden;cursor:pointer;text-decoration:none;color:#228822'" + lEvt + lVS + ">{STORE}</a>" +
                "   <input type=button style='width:116px;height:24px;text-align:center;position:absolute;top:6" + ( sfb.psuSupportedBy ? 5 : 9 ) + "px;left:104px;background:#e2e2e2;" +
            "filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#ffffff, endColorstr=#c3c3c3);background: -moz-linear-gradient(top,  #ffffff,  #c3c3c3);background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#c3c3c3));" +
            "border:solid 1px; border-color:#989898 #838382 #7f7f80 #6f6f6f;-moz-border-radius:4px;border-radius:4px;-webkit-border-radius:4px;cursor:pointer;font:arial,sans-serif;font-weight:normal;font-size:13px;color:#000000;' onclick='superfish.b.psuGlide();' title=' Click to See More Results ' value=' Compare Prices '/>" +
            "   <a id = 'SF_SLIDE_UP_CPN' onclick='superfish.util.reportCoupon(1);' style='display:block;text-align: left;overflow:hidden;white-space: nowrap;width:142px;position:absolute;top:90px;left:105px;"+ fnt +"font-size:11px;font-weight:300;color:#ff5d2f;text-decoration:none;'"+ lEvt +" href=''>{NUM}: {STORE2}</a>" +
            "   <div id='SF_PSU_PAUSE_PROMPT' style='width:220px;height:85px;display:none;position:absolute;top:-79px;left:38px;background:url(" + imUrlDef + "bgPSuP.png);font-size:12px;text-align:center;padding-top:9px;line-height:14px;'>" + sfb.partnerPausePopup +
            "       <table border='0' cellspacing='0' cellpadding = '0' style='margin:1px auto 0;padding:0;'><tbody><tr><td style='padding:0;'><div id='SF_PSU_B_PAUSE_OK' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px -20px no-repeat;' " + bEvt + "></div></td>" +
            "       <td style='padding:0;'><div id='SF_PSU_B_CLOSE' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px 0px no-repeat;' " + bEvt + "></div></td></tr></tbody></table></div>" +
            "</div>"            
        );
        return ret;
    }
    return "";
};


superfish.b.getIh = function(obj, i) {
    var spp = spsupport.p;
    var ast = "border: none !important;";
    var fnt = "font-family:Arial,Helvetica,Verdana;";
    var lVS = " title=' Visit Store ' ";
    var lEvt = " target='_blank' onmouseover='superfish.b.psuLinkEv(this,1)' onmouseout='superfish.b.psuLinkEv(this,0)'";
    var it = obj[0], it2 = obj[1];
    var tr = " <span style='border-bottom: 3px solid transparent;border-left: 3px solid #FF5D2F;border-top: 3px solid transparent;display: inline-block;line-height: 0;'></span>";

    
    return("<div style = 'position:relative; height: "+this.agrSu+"px;'>" +
            "   <a id='SF_SLIDE_UP_VISIT_4' href ='" + it.merchURL + "&clickSrc=3' target='_blank' style='" + ast + "text-align: left;color: #3A00FF !important;text-decoration: underline; cursor: pointer; display: inline-block; font-family: Helvetica !important; font-size: 13px !important; height: 32px;left: 132px;line-height: 15px;margin-right: 15px;overflow: hidden;padding: 0 !important;position: absolute; top: 19px;'>"+it.title+"</a> " +
            "   <a id='SF_SLIDE_UP_VISIT_1' href ='" + it.merchURL + "&clickSrc=1' target='_blank' style='-moz-border-radius: 7px 7px 7px 7px;background: none repeat scroll 0 0 #FFFFFF;border: 1px solid #D0D0D0;cursor: pointer;float: left;height: 110px;margin: 1px 4px;padding: 4px;width: 110px;-webkit-border-radius:7px;cursor:pointer;'" + lVS + ">" +
                "      <img id='SF_PSU_IMG_OBJ' " + spp.sfIcon.evl+ "='-1' sfnoicon='1' src = '"+it.imagePath+"' style='width:110px;height:110px;display:inline-block;border: none !important;' />" +
            "   </a>" +
                "   <a id='SF_SLIDE_UP_VISIT_2' href ='" + it.merchURL + "&clickSrc=4' target='_blank' style='" + ast + "text-align: left;top: 53px;color: #333333 !important;cursor: pointer;font-family: Helvetica;font-size: 16px !important;font-weight: bold;left: 132px;text-decoration: none;margin: 0 0 1px;position: absolute;" + fnt + "'" + lVS + lEvt + ">"+it.price+"</a>" +
                "   <a id='SF_SLIDE_UP_VISIT_3' href ='" + it.merchURL + "&clickSrc=5' target='_blank' style='" + ast + "text-align: left;left: 210px;color: #008000 !important;cursor: pointer;font-size: 12px;line-height: 19px;overflow: hidden;position: absolute;text-decoration: none;top: 52px;white-space: nowrap;width: 123px;" + fnt + "'" + lEvt + lVS + ">"+it.merchantName+"</a>" +
                (it.cupon ? 
                "   <a id = 'SF_SLIDE_UP_CPN' href='"+ it.cupon.url +"' onclick='superfish.util.reportCoupon("+((i+1)*2-1)+");' style='" + ast + "display:block;text-align: left;overflow:hidden;white-space: nowrap;position:absolute;top:65px;left:210px;"+ fnt +"font-size:11px;font-weight:bold;color:#ff5d2f;text-decoration:none;'"+ lEvt +">"+it.cupon.num + " coupon" + (it.cupon.num > 1 ? "s" : "") + tr+"</a>" : "") +
                (it2 ?
                "   <a id='SF_SLIDE_UP_VISIT1_2' href ='" + it2.merchURL + "&clickSrc=4' target='_blank' style='" + ast + "text-align: left;top: 78px;color: #333333 !important;cursor: pointer;font-family: Helvetica;font-size: 16px !important;font-weight: bold;left: 132px;text-decoration: none;margin: 0 0 1px;position: absolute;" + fnt + "'" + lVS + lEvt + ">"+it2.price+"</a>" +
                "   <a id='SF_SLIDE_UP_VISIT1_3' href ='" + it2.merchURL + "&clickSrc=5' target='_blank' style='" + ast + "text-align: left;left: 210px;color: #008000 !important;cursor: pointer;font-size: 12px;line-height: 19px;overflow: hidden;position: absolute;text-decoration: none;top: 77px;white-space: nowrap;width: 123px;" + fnt + "'" + lEvt + lVS + ">"+it2.merchantName+"</a>" +
                (it2.cupon ? 
                "   <a id = 'SF_SLIDE_UP_SECOND' href='"+ it2.cupon.url +"' onclick='superfish.util.reportCoupon("+((i+1)*2)+");' style='" + ast + "display:block;text-align: left;overflow:hidden;white-space: nowrap;position:absolute;top:91px;left:210px;"+ fnt +"font-size:11px;font-weight:bold;color:#ff5d2f !important;text-decoration:none;'"+ lEvt +">"+it2.cupon.num + " coupon" + (it2.cupon.num > 1 ? "s" : "") + tr+"</a>" : "") : "") +
           "</div>"     
        );

}

   
superfish.b.psuLinkEv = function( lnk, over) {
    lnk.style.textDecoration = ( over ? "underline" : "none" );
};

superfish.b.psuBtnEvt = function (btn, evt) {
    var xP = ( evt == 0 || evt == 4  ? "0" : ( evt == 1 ? "-57" : "-114" ) ) + "px ";
    var yP = (btn.id == "SF_PSU_B_PAUSE_OK" ? -20 : 0 ) + "px";
    btn.style.backgroundPosition = xP + yP;
    if( evt == 4){
        sufio.byId("SF_PSU_PAUSE_PROMPT").style.display = "none";
        if (btn.id == "SF_PSU_B_PAUSE_OK") {
                superfish.util.sendRequest("{\"cmd\": 2, \"type\": 1 }");
                var bt = sufio.byId("SF_SLIDE_UP_CLOSE");
                sufio.attr( bt, "upp", "0" );
                superfish.b.closePSU(bt, 4);
        }
    }
};

superfish.b.closePSU = function( btn, evt, timer ){
    var up = (+sufio.attr( btn, "upp" ));
    if (timer && up != 0) {
        return;
    }
    var yP = ( btn.id == 'SF_SLIDE_UP_CLOSE' ? (up == 1 ? -22 : (up == -1 ? -64 : 0)) : -43) + "px";
    var bb = (this.agrSu ? "#ff9944" : "#c3c3c3");
    var bb2 = (this.agrSu ? "#ff5400" : "#888888");
    if (superfish.util.busy && !superfish.b.newSu) {
        btn.style.backgroundPosition = "-63px " + yP;
    }
    else {
        var pSu = superfish.util.preslideup();
        if (evt != 5) {
            if (superfish.b.newSu) {
                btn.style.backgroundColor = ( evt == 0 ? bb : bb2);
            }
            else {
                btn.style.backgroundPosition = ( evt == 1 ? "-42px " + yP : ( evt == 2 ? "-21px " + yP : ( !evt ? "0px " + yP : "-42px " + yP ) ) );
            }
        }
        if ((evt == 4 || evt == 5) && !superfish.util.busy) {
            if( btn.id == 'SF_SLIDE_UP_CLOSE'){
                var vp = sufio.window.getBox();
                if ( up == 1 ){
                    var t = vp.h + 10;
                    if (spsupport.p.isIEQ) {
                        t = t + vp.t
                    }
                    sufio.byId( "SF_SLIDE_UP_SLEEP" ).style.display='block';

                    sufio.animateProperty({
                        node:  superfish.util.bubble(),
                        duration: 850,
                        properties: {
                            top: t
                        },
                        onEnd: function(node){
                            node.style.top = (t - 3000) + "px";
                        }
                    }).play(30);
                    var t2 = vp.h - ( parseInt( pSu.style.height));
                    t2 = (superfish.b.newSu ? t2 - 15 : t2);
                    if ( spsupport.p.isIEQ ) {
                        t2 = t2 + vp.t;
                    }
                    superfish.b.movePSU(pSu, btn, 800, t2, 0, "0px 0px", 0);
                }
                else if ( up == 0 ){
                    if (evt == 4) {
                        sufio.fadeOut({
                            node: "SF_SLIDE_UP",
                            duration: 200,
                            onEnd: function() {
                                superfish.util.closePopup();
                            }
                        }).play();
                    }
                    else if (evt == 5) {
                        t2 = vp.h - spsupport.p.psuRestHeight;
                        if (spsupport.p.isIEQ) {
                            t2 = t2 + vp.t
                        }
                        superfish.b.movePSU(pSu, btn, 1900, t2, -1, "0px -64px", 1);
                    }
                }
                else if ( up == -1 ){
                    t2 = vp.h - parseInt(pSu.style.height);
                    t2 = (superfish.b.newSu ? t2 - 15 : t2);
                    if (spsupport.p.isIEQ) {
                        t2 = t2 + vp.t
                    }
                    superfish.b.movePSU(pSu, btn, 1900, t2, 0, "0px 0px", 1);
                }
                superfish.b.slideUpOn = 0;
            }
            else if( btn.id == 'SF_SLIDE_UP_SLEEP') {
                sufio.byId("SF_PSU_PAUSE_PROMPT").style.display = "block";
            }
        }
    }
};
    
superfish.b.activateHeader = function() {
    superfish.b.closePSU( sufio.byId('SF_SLIDE_UP_CLOSE'), 5, 0);
};
    
superfish.b.movePSU = function(node, btn, duration, top, up, bgPos, bounce) {
    superfish.b.preSlideUpOn = up + 2;
    top = superfish.publisher.fixSuPos(top);
    var prop = {
        node:  node,
        duration: duration,
        properties: {
            top: top
        },
        onEnd:  function(){
            btn.style.backgroundPosition = bgPos;
            sufio.attr( btn, "upp", up );
            sufio.attr( btn, "title", superfish.b.titles[(up == 0 ? 3 : up+1)] );
        }
    };
    if (bounce && sufio.fx && sufio.fx.easing) {
        prop.easing = sufio.fx.easing.bounceOut;
    }
    sufio.animateProperty(prop).play();
    sufio.byId("SF_PSU_PAUSE_PROMPT").style.display = "none";
};

superfish.b.hidePSU = function(){
    clearTimeout(superfish.b.tm);
    if ( superfish.b.preSlideUpOn ){
        sufio.byId( "SF_SLIDE_UP" ).style.display='none';
        superfish.b.preSlideUpOn = 0;
        sufio.attr( "SF_SLIDE_UP_CLOSE", "upp", 0 );
    }
};
    
superfish.b.initPSU = function( data ){
    var obj = sufio.eval(data);
    var su = sufio.byId( "SF_SLIDE_UP" );
    if( su ){
        document.body.removeChild( su );
    }
    
    var ht = "";
//    var itn = ((this.agrSu && obj.length > 2) ? 2 : 1);
    for (var i = 0; i < obj.length; i++) {
        ht += this.getIh(obj[i], i);
    }
    
    su = sufio.place( superfish.b.createPSU(ht), sufio.body() );
    if (su) {        
        var vp = sufio.window.getBox();
        var t = vp.h + 10;
        var l = vp.w - parseInt( su.style.width );
        l = (superfish.b.newSu ? l - 16 : l - 40);
        if (spsupport.p.isIEQ) {
            t = t + vp.t;
            l = l + vp.l;
        }
        sufio.style(
            su ,{
                top : t + "px",
                left : l + "px",
                display : "block"
            });

        var t2 = superfish.publisher.fixSuPos(parseInt( su.style.top ) - parseInt( su.style.height ));
        t2 = (superfish.b.newSu ? t2 - 25 : t2 - 10);

        var prop = {            
            node:  su,
            duration: 1900,
            properties: {
                top: t2
            }
        };
        if (sufio.fx && sufio.fx.easing) {
            prop.easing = sufio.fx.easing.bounceOut;
        }
        sufio.animateProperty(prop).play();

        superfish.b.preSlideUpOn = 2;
        
        su.onclick = function() {
            if (!superfish.b.psuActive) {
                superfish.b.psuActive = 1;
            }
        };

        su.onmouseover = function() {
            if (!superfish.b.psuActive) {
                clearTimeout(superfish.b.tm);
            }
        };

        su.onmouseout = superfish.b.setTimer;
    }
};

superfish.b.setTimer = function() {
    if (!superfish.b.psuActive) {
        superfish.b.tm = setTimeout(function() {
            superfish.b.psuActive = 1;
            var btn = sufio.byId( "SF_SLIDE_UP_CLOSE" );
            if (btn) {
                superfish.b.closePSU(btn, 5, 1);
            }
        }, superfish.b.slideUpTime);
    }
};
 
            
   
superfish.b.psuGlide = function(){
    var su = superfish.util.bubble();
    var psu = superfish.util.preslideup();
    var vp = sufio.window.getBox();
    var t = vp.h + 4;
    var l = vp.w - superfish.p.width - 4;
    if (spsupport.p.isIEQ) {
        t = t + vp.t;
        l = l + vp.l;
    }
        
    su.style.top = t + "px";
    su.style.left = l + "px";
    var step1 = superfish.publisher.fixSuPos(t - 4 - parseInt(psu.style.height) + spsupport.p.psuHdrHeight);
   // var step = parseInt( su.style.top ) - superfish.p.height - 10;
    var step = parseInt( su.style.top ) - (superfish.p.height+superfish.util.hdr*2) - 6;

    sufio.byId("SF_PSU_PAUSE_PROMPT").style.display = "none";
    sufio.byId( "SF_SLIDE_UP_SLEEP" ).style.display = "none";
    sufio.animateProperty({
        node:  su,
        duration: 250,
        properties: {
            top: step1
        },
        onEnd: function() {
            superfish.b.movePSU(psu, sufio.byId("SF_SLIDE_UP_CLOSE"), 600, step - spsupport.p.psuHdrHeight, 1, "0px -22px", 0);
            sufio.animateProperty({
                node:  su,
                duration: 600,
                properties: {
                    top: superfish.publisher.fixSuPos(step)
                }
            }).play();
        }
    }).play();
        
    setTimeout( function(){
        var sp = spsupport.p;
        spsupport.api.jsonpRequest(
            sp.sfDomain_ + sp.sessRepAct,
            {
                "action" : "full slideup",
                "userid" : sp.userid,
                "sessionid" : superfish.util.currentSessionId
            } )
    }, 1500);
    superfish.b.slideUpOn = 1;
};
                superfish.inimg = {    
    h: 60,
    iw: 60,
    pd: 3,
    inf: 70,
    g: '#C3C3C3',
    g2: '#acaeb0',
    itn: 0,

    vi: function(imw, imh) {
        var h = this.h*2;
        if (imh > h) {
            var sp = imw - this.inf + 4, iw = this.iw + this.pd*2;
            this.itn = parseInt(sp/iw);
            if (this.itn > 1) {
                this.gp = parseInt(sp%iw/2);
                return this.itn;
            }
             else {
                this.itn = 0;
                return 0;
            }            
        }
        else {
            return 0;
        }
    },
    
    cr: function(ht, b) {
        var s = this.p.prodPage.p.style.padding;
        var pb = 0, pl = 0, pr = 0;
        if (s.length > 0) {
            s = s.split(' ');
            switch(s.length){
                case 1:
                    pb = pl = pr = parseInt(s[0]);
                    break;
                case 2:
                    pb = parseInt(s[0]);
                    pl = pr = parseInt(s[1]);
                    break;
                case 3:
                    pb = parseInt(s[2]);
                    pr = parseInt(s[1]);
                    break;
                case 4:
                    pb = parseInt(s[2]);
                    pr = parseInt(s[1]);
                    pl = parseInt(s[3]);
                    break;
            }
        }
        this.y = this.lai.y + this.lai.h - this.h + pb + 1;
        this.w += (pl+pr);
        var bs = 'height:'+ this.h +'px;position: absolute;';
        var as = 'border: none !important;';
        var ft = 'font-family:Arial,Helvetica,Verdana !important;font-size:7pt !important;color:#999999 !important;text-decoration:none !important;';
        return (        
            '<div id = "SF_IIAD" style = "'+ bs +'width:'+ this.w +'px;background: transparent; border: solid 2px ' + this.g2 + '; overflow: hidden; z-index: 12010 !important; left: '+ this.lai.x +'px; top: '+ this.y +'px;">' +
                '<div style = "'+ bs +'width:'+ (this.w - this.gp) +'px;z-index: -1;background: #ffffff; opacity:0.9; filter: alpha(opacity=90); left: 0 !important;top: 0 !important;padding-left:'+this.gp+'px;">' +
                ht +
                '</div>' +
                ( b.psuSupportedBy ?
                    '<a target = "_blank" onmouseover = "this.style.textDecoration = \'underline\';" onmouseout = "this.style.textDecoration = \'none\';" style="' + as + 'position:absolute;top:'+(this.h - 10)+'px;right:1px;line-height:8px !important;' + ft + '" href="' +
                    b.psuSupportedByLink + '" title="' + b.psuSupportedByTitle + '">' +
                    b.psuSupportedByText + '</a>'
//                    '<a target = "_blank" style="' + as + 'position:absolute;top:'+(this.h - 8)+'px;right:0px; width: 50px; height: 10px; background: transparent url('+ this.p.sfDomain + 'inimg/img/all.png' +') -4px -29px no-repeat;" href="' +
//                    b.psuSupportedByLink + '" title="' + b.psuSupportedByTitle + '">' +
//                    '</a>'
                    : '' )+
//                    '<div id="SF_IIAD_PROMPT" style="width:220px;height:85px;display:none;position:absolute;top:-89px;right: -28px;background: url('+ this.p.sfDomain + 'inimg/img/bgPr.png) no-repeat; font-size:12px;text-align:center;padding-top:9px;line-height:14px;">' + b.partnerPausePopup +
//                    '<table border="0" cellspacing="0" cellpadding = "0" style="margin:1px auto 0;padding:0;"><tbody><tr><td style="padding:0;"><div id="SF_IIAD_OK" style="margin:2px;width:57px;height:20px;background: url('+ this.p.sfDomain + 'inimg/img/bgPr.png) 0px -20px no-repeat;"></div></td>' +
//                    '<td style="padding:0;"><div id="SF_IIAD_CLOSE" style="margin:2px;width:57px;height:20px;background: url('+ this.p.sfDomain + 'inimg/img/bgPr.png) no-repeat;"></div></td></tr></tbody></table></div>' +
            '</div>'    
        );
    },

    tr: function(st, n, dl){
        dl = (dl ? dl : ' ');
        if (!n || st.length < n) {
            return st;
        }
        else {
            var aw = st.split(dl); //, i = 1;
            var rt = aw[0];
            for(var i = 1; i < aw.length; i++) {
                if (rt.length + dl.length + aw[i].length <= n) {
                    rt += dl + aw[i];
                }
                else {
                    break;
                }
            }
            rt = (rt.length > n ? rt.substring(0, n-1) : rt);
            return rt;
        }
    },
    
    ih : function(it, i) { /* item html */
        if (it) {
            var t = this;
            var tr = 'target = "_blank"';
            var l = 12;
            var pr = (it.price.length > 6 ? it.price.split('.')[0] : it.price);
            var tl = t.tr(it.title, 12);
            var st = t.tr(it.merchantName.split('.com')[0], 12);
            var tc = 'border: none !important; color: #222222 !important; cursor: pointer; height: ' + l + 'px; display: block; font-family: Helvetica !important; font-size: 11px !important; line-height: 11px;overflow: hidden;padding: 0; text-align: center;';
            return(
                '<div id = "SF_IIAD_ITEM' + i + '" style="position:static; margin: 4px 0 2px 0; overflow: hidden; text-align: center; width: '+ t.iw +'px;padding: 0 '+ t.pd +'px; display: block; float: left; vertical-align: top; font-family: arial,sans-serif !important; font-size: small !important; line-height: 1.2 !important;">' +
                    '<div id = "SF_IIAD_ITEM_INFO' + i + '" style = "display: none; width: '+ t.iw +'px; padding: '+ t.pd +'px; height: '+(l*3+3)+'px; position: absolute; bottom: 0; left: '+ ((t.iw+t.pd*2)*i+t.gp) +'px; background: '+ t.g +'">' +
                        '<a href="'+ it.merchURL +'&clickSrc=3" ' + tr + ' style = "' + tc + 'text-decoration: none;">'+ tl +'</a>' +
                        '<a href="'+ it.merchURL +'&clickSrc=5" ' + tr + ' style = "' + tc + 'text-decoration: underline;">'+ st +'</a>' +
                        '<a id = "SF_IIAD_ITEM_PR_' + i + '" href="'+ it.merchURL +'&clickSrc=4" ' + tr + ' style = "' + tc + 'padding-top: 3px;text-decoration: none;">' + pr + '<div id = "SF_IIAD_ITEM_PR_BT_' + i + '" style="width: '+l+'px; height:'+l+'px;background: transparent url('+ t.p.sfDomain + 'inimg/img/all.png' +') -104px -1px no-repeat; display: inline-block; vertical-align: middle; margin-left: 3px;"></div></a>'+
                    '</div>' +
                    '<a id = "SF_IIAD_A' + i + '" href="'+ it.merchURL + '&clickSrc=1" ' + tr + ' style = "display: block; width: '+(t.iw - 8)+'px; height: '+(t.iw - 8)+'px; text-align: center; vertical-align: middle; border:none;">' +
                        '<img id="SF_IIAD_IMG_' + i + '" ' + t.p.sfIcon.evl+ '="-1" sfnoicon="1" style="width:'+(t.iw - 10)+'px; height:'+(t.iw - 10)+'px; display: inline-block; border: none; padding: 1px;display:none;" />' +
                        '<img id= "SF_II_LOAD_' + i + '" src = "' + t.sp.src + '" style="width:'+(t.iw - 10)+'px; height: '+(t.iw - 10)+'px; display: inline-block; border: none; padding: 1px;" />' +
                    '</a>' +
                '</div>'
                );
        }
        else {
            return '';
        }
    },
    
    im: function(nd, sp) {  /* show image */
        var t = this;
        var s = t.fio.query('#' + sp, nd.parentNode)[0];
        t.fio.style(nd, 'opacity', '0');
        if (s) {
            s.style.display = 'none';
        }
        nd.style.display = 'inline';
        t.fio.fadeIn({
            node: nd,
            duration: 600
        }).play(1);
    }, 
    
    bt: function(nd, e, bt) { /* button: 1 - snooze, 2 - close */
        var t = this;
        if (nd) {
            nd.style.backgroundColor = ( e == 0 ? t.g2 : '#888888');
        }
        if (e == 2) {
            if (bt == 1) {
               // this.fio.byId("SF_IIAD_PROMPT").style.display = "block";
               var r = t.h - 10;
               if (t.up) {
                    t.mv((t.y + r), (t.h - r), 0);
                    nd.style.backgroundPosition = '-64px -13px';
               }
               else {
                    t.mv(t.y, t.h, 1);
                    nd.style.backgroundPosition = '-64px -26px';
               }
            }
            else if( bt == 2) {
                this.u.closePopup();
                this.cl();
            }
        }
    },

    mv: function(tp, h, nu) {
        var t = this;
        var pr = {
            node:  t.ii,
            duration: 800,
            properties: {
                top: tp,
                height: h
            },
            onEnd: function() {
                t.up = nu;
            }
        };
        t.fio.animateProperty(pr).play();
    },

//    be : function (bt, e) { /* button event */
//        var xP = ( e == 0 || e == 4  ? "0" : ( e == 1 ? "-57" : "-114" ) ) + "px ";
//        var yP = (bt.id == "SF_IIAD_OK" ? -20 : 0 ) + "px";
//        bt.style.backgroundPosition = xP + yP;
//        if( e == 2){
//            this.fio.byId("SF_IIAD_PROMPT").style.display = "none";
//            if (bt.id == "SF_IIAD_OK") {
//                    this.u.sendRequest("{\"cmd\": 2, \"type\": 1 }");
//                    this.bt(0, 2, 2);
//            }
//        }
//    },

    cl: function() {
        var t = this;
        if (t.ii) {
            t.fio.destroy(t.ii);
            t.p.prodPage.p.removeAttribute('sfnoicon');
//            t.p.prodPage.p.removeAttribute(t.p.sfIcon.evl);
            t.u.enumDom();
        }
    },
    
    pl: function() {  /* show plugin */
        var t = this;
        var o = t.lai;
        var pp = t.u.bubble();
        var ps = t.u.getPosition(o.x, o.y, o.w, o.h);
        pp.style.top = ps.y + "px"; 
        pp.style.left = ps.x + "px";
        pp.style.position = 'absolute';
        setTimeout( function(){
            t.u.jpR(t.p.sfDomain_ + t.p.sessRepAct,
                {
                    "action" : "full slideup",
                    "userid" : t.p.userid,
                    "sessionid" : t.u.currentSessionId
                } )
        }, 1500);

    },

    si: function(it, e) {  /* show info */
       var i = it.id.split('SF_IIAD_ITEM')[1];
//       var im = this.fio.query('a[id="SF_IIAD_A' + i + '"]', it)[0];
       var inf = this.fio.query('div[id="SF_IIAD_ITEM_INFO' + i + '"]', it)[0];
       if (e) {
           inf.style.display = 'block';
        }
        else {
           inf.style.display = 'none';
        }
    },

    pr: function(it, e) {  /* price button */
       // var i = it.id.split('SF_IIAD_ITEM')[1];
       var bt = this.fio.query('div', it)[0];
       if (e) {
           bt.style.backgroundPosition = '-89px -1px';
        }
        else {
           bt.style.backgroundPosition = '-104px -1px';
        }
    },

    cn: function(b) {
        var a = [], n = [];
        var s = '10px', c = 62;
        var t = this;
//        var ns = 'text-transform: uppercase; font-family: Arial; font-weight: bold;';
//        a[0] =  '<div id="SF_IIAD_SLEEP" style="background:url('+ t.p.sfDomain + 'inimg/img/all.png' +') no-repeat -4px -47px '+ t.g2 +';width:'+ s +';height:'+ s +';position:absolute;top:0;right:'+ s +';cursor:pointer;" title="Click to disable ' + b.shareMsgProd + ' slide-up"></div>';
        a[0] =  '<div id="SF_IIAD_MOVE" style="background: url('+ t.p.sfDomain + 'inimg/img/all.png' +') -64px -26px no-repeat '+ t.g2 +';width:'+ s +';height:'+ s +';position:absolute;top:0;right:'+ s +';cursor:pointer;"></div>';
        a[1] = '<div id="SF_IIAD_CLOSE" title="' + b.titles[3] + '" style="position:absolute;top:0;right:0;height:'+ s +';width:'+ s +';background: url('+ t.p.sfDomain + 'inimg/img/all.png' +') -64px -1px no-repeat '+ t.g2 +';z-index:200100;cursor:pointer;"></div>';
//        a[2] ='<div id = "SF_IIAD_INF" style = "margin-top: 14px;text-align: center; width: '+ t.inf +'px; float: right;cursor:pointer;">' +
//                    '<div style = "'+ ns +' font-size: 15px !important; color: #e15600 !important">Get this</div>' +
//                    '<div style = "'+ ns +' font-size: 12px !important; color: #838589 !important">More</div>' +
//                '</div>';
        a[2] ='<div id = "SF_IIAD_INF" style = "margin-top: 16px; text-align: center; width: '+ t.inf +'px; margin-right: 4px; float: right;cursor:pointer;">'+
                '<div style = "width: ' + c + 'px; height: 30px; margin-left: ' + ((t.inf - c)/2) + 'px; background: transparent url('+ t.p.sfDomain + 'inimg/img/all.png' +') 0 0 no-repeat;"></div>' +
              '</div>';
            
        for (var i = 0; i < a.length; i++) {
            n[i] = t.fio.place(a[i], t.ii);
        }
        
        n[0].onmouseover = function(){t.bt(this, 1, 1); };
        n[1].onmouseover = function(){t.bt(this, 1, 2); };
        n[0].onmouseout = function(){t.bt(this, 0, 1); };
        n[1].onmouseout = function(){t.bt(this, 0, 2); };
        n[0].onclick = function(){t.bt(this, 2, 1); };
        n[1].onclick = function(){t.bt(this, 2, 2); };
        n[2].onclick = function(){t.pl();};

//        var ok = t.fio.query('div[id="SF_IIAD_OK"]', t.ii)[0];
//        var cn = t.fio.query('div[id="SF_IIAD_CLOSE"]', t.ii)[0];
//
//        ok.onmouseover = function() {t.be(this, 1, 1); };
//        cn.onmouseover = function() {t.be(this, 1, 2); };
//        ok.onmouseout = function() {t.be(this, 0, 1); };
//        cn.onmouseout = function() {t.be(this, 0, 2); };
//        ok.onclick = function() {t.be(this, 2, 1); };
//        cn.onclick = function() {t.be(this, 2, 2); };
        
    },

    init: function(dt, sufio, sfu, p, b) {
        var t = this;
        t.p = p;
        t.u = sfu;
        t.fio = sufio;
        t.lai = sfu.lastAIcon;     /* last active icon */
        t.ic = p.prodPage.p.ni
        t.w = t.lai.w - 2;

        t.sp = new Image();
        t.sp.src = t.p.sfDomain + 'inimg/img/as.gif';

        var o = t.fio.eval(dt);
        var im;
        
        t.ii = t.fio.byId("SF_IIAD");
        if(t.ii){
           t.fio.destroy(t.ii);
        }
        
        var ht = "";
        for (var i = 0; i < t.itn; i++) {
            ht += t.ih(o[i], i);
        }
        t.ii = t.fio.place(t.cr(ht, b), t.fio.body());
        t.up = 1;
        if (!(+superfish.b.sgIc) && t.ic) {
            t.ic.style.display = 'none'; 
        }
        t.fio.attr(t.p.prodPage.p, 'sfnoicon', '1'); 
        // t.fio.attr(t.p.prodPage.p, t.p.sfIcon.evl, '-1');
        
        t.cn(b);
        var it, pr;
        for (i = 0; i < t.itn; i++) {
            it = t.fio.query('div[id="SF_IIAD_ITEM'+i+'"]', t.ii)[0];
            if (it) {
                it.onmouseover = function () {
                    t.si(this, 1);
                };
                it.onmouseout = function () {
                    t.si(this, 0);
                };
            }
            pr = t.fio.query('a[id="SF_IIAD_ITEM_PR_' + i + '"]', t.ii)[0];
            if (pr) {
                pr.onmouseover = function () {
                    t.pr(this, 1);
                };
                pr.onmouseout = function () {
                    t.pr(this, 0);
                };
            }

            im = t.fio.byId( "SF_IIAD_IMG_" + i );
            if (im) {
                im.onload = function(im, sp){
                    return function(){
                        t.im(im, sp);
                    }
                }(im, 'SF_II_LOAD_'+i); 

                im.src = o[i].imagePath;
            }
        }
    }
    
};
                
            
                superfish.sg = {
    sSite: 0,
    offset: 0,
    relpos: 'after',
    showStore: 1,
    cssMainTitle: '',
    itemWidth: 98,
    lines: 1,
    cssMain: '',
    sleepTime: 1000*60*60*24,
    sleepText: ' 24 hours',
    powered1: 'Powered by&nbsp;',
    cssPowered: 'text-align:right; color: #0E774A; font-size: 12px;',
    cssPrompt: 'right:-3px; top:14px;',

    init : function(data) {
        this.obj = sufio.eval(data);
        var prB = sufio.query(this.q);
        if ( prB.length > 0 ) {
            prB = prB[ 0 ].parentNode;
            var box = sufio.coords(prB);             
            var anc = prB.children[this.offset];
            
            var perLine = parseInt(box.w/(this.itemWidth + 8));
            var itemsNum = Math.min(perLine*this.lines, this.obj.length);
            var html = "";
            for (var i = 0; i < itemsNum; i++) {
                if (i != 0 && i%perLine == 0) {
                    html += "<br style='clear: both;' />";
                }
                html += this.getItemHtml(this.obj[i], i);
            }
            this.close();
            this.sg = sufio.place(this.create(html), anc, this.relpos);
            var im;
            for ( i = 0; i < itemsNum; i++) {
                im = sufio.byId( "SF_SRG_IMG_" + i );
                if (im) {
                    im.src = this.obj[i].imagePath;
                }
            }

            spsupport.api.startDOMEnumeration();
        }
    },

    create : function(html) {
        return(
            "<div id = 'SF_SEARCHGET' style='width:100%; margin-bottom: 14px;position: relative;"+this.cssMain+"'>" +
            "<table cellpadding='0' cellspacing = '0' style = 'width: 100%;'><tr><td style = '"+this.cssMainTitle+"'>Visual Search results</td>" +
            "<td style='" + this.cssPowered + "'>"+this.powered1+"<a href = '"+ superfish.b.sgSupportedByLink +"' target='_blank' style='" + this.cssPowered + "'>"+ superfish.b.sgSupportedByText +"</a>&nbsp;&nbsp;<span id = 'SF_SG_CLOSE' style='cursor: pointer;' onclick='superfish.sg.sleep()'>[x]</span></td></tr></table>" +
            html +
            "<br style='clear: both;' />"+
            "</div>");
    },

    getItemHtml : function(item, index) {
        var sp = spsupport.p;
        if (item) {
            var spin = 'SF_loading'+index;
            return(
                "<div style='margin-top: 7px;  overflow: hidden; text-align: left; width: "+ this.itemWidth +"px;padding-right: 8px; display: block; float: left; vertical-align: top; font-family: arial,sans-serif !important; font-size: small !important; line-height: 1.2 !important;'>" +
                "<a href='"+ item.merchURL +"&clickSrc=1' target='_blank' style = 'display: block; width: 82px; height: 82px; text-align: center; vertical-align: middle; border:1px solid #1111CC;'>" +
                "<img id='SF_SRG_IMG_" + index + "' " +sp.sfIcon.evl+ "='-1' sfnoicon='1' style='width:80px; height:80px; display: inline-block; border: none; padding: 1px;display:none;' onload='superfish.sg.showImage(this, \""+spin+"\");' />" +
                "<img id= '" + spin + "' src = '" + sp.iSpin.src + "' style='width:80px; height:80px; display: inline-block; border: none; padding: 1px;' />" +
                "</a>" +
                "<a href='"+ item.merchURL +"&clickSrc=3' target='_blank' style='"+this.cssTitle+"'>"+ item.title +"</a>" +
                "<div style = '"+this.cssPrice+"'>" + item.price + "</div>"+
                (this.showStore ? "<a href='"+ item.merchURL +"&clickSrc=5' target='_blank' style='"+this.cssStore+"'>"+item.merchantName+"</a>" : "") +
                "</div>"
                );
        }
        else {
            return "";
        }
    },

    showImage: function(node, spinId) {
        var spin = sufio.query('#' + spinId, node.parentNode)[0];
        sufio.style(node, 'opacity', '0');
        if (spin) {
            spin.style.display = 'none';
        }
        node.style.display = 'inline';
        sufio.fadeIn({
            node: node,
            duration: 600
        }).play(1);
    },

    close : function() {
        var sg = sufio.byId( "SF_SEARCHGET" );
        if( sg ){
            sufio.destroy(sg);
        }
    },


    sleep : function() { 
        var imUrlDef = spsupport.p.imgPath;
        var bEvt = " onmouseover='superfish.sg.sgBtnEvt(this,1)' onmouseout='superfish.sg.sgBtnEvt(this,0)' onmousedown='superfish.sg.sgBtnEvt(this,2)' onmouseup='superfish.sg.sgBtnEvt(this,4)' ";
        var prompt = "<div id='SF_SG_PAUSE_PROMPT' style='width:220px;height:76px;background:url(" + imUrlDef + "bgPSgP.png);position: absolute;z-index:10; font-size:12px;text-align:center;padding-top:18px;line-height:14px;"+this.cssPrompt+"'>" + superfish.b.sgPrompt + this.sleepText +
        "       <table border='0' cellspacing='0' cellpadding = '0' style='margin:1px auto 0;padding:0;'><tbody><tr><td style='padding:0;'><div id='SF_SG_B_PAUSE_OK' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px -20px no-repeat;' " + bEvt + "></div></td>" +
        "       <td style='padding:0;'><div id='SF_SG_B_CLOSE' style='margin:2px;width:57px;height:20px;background:url(" + imUrlDef + "bPreSu.png) 0px 0px no-repeat;' " + bEvt + "></div></td></tr></tbody></table>" +
        "</div>"
        this.pr = sufio.byId( "SF_SG_PAUSE_PROMPT" );
        if (this.pr) {
            this.pr.style.display = 'block';
        }
        else {
            this.pr = sufio.place(prompt, this.sg);
        }
    },

    sgBtnEvt : function (btn, evt) {
        var xP = ( evt == 0 || evt == 4  ? "0" : ( evt == 1 ? "-57" : "-114" ) ) + "px ";
        var yP = (btn.id == "SF_SG_B_PAUSE_OK" ? -20 : 0 ) + "px";
        btn.style.backgroundPosition = xP + yP;
        if( evt == 4){
            this.pr.style.display = "none";
            if (btn.id == "SF_SG_B_PAUSE_OK") {
                superfish.util.sendRequest("{\"cmd\": 2, \"type\": 2, \"cookie\": \""+this.cookie+"\", \"sleep\": \""+this.sleepTime+"\" }");
                this.close();
                spsupport.api.startDOMEnumeration();
            }
        }
    }
};


            
    }
}
