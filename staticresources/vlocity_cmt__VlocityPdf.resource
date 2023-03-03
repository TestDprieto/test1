var buffer;
var pako;

/** 'buffer' nodejs module minified for AMD, CommonJS & `window.buffer`. browserify v3.46.1 **/
!function(t){if("object"==typeof exports)module.exports=t();else if("function"==typeof define&&define.amd)define(t);else{var e;"undefined"!=typeof window?e=window:"undefined"!=typeof global?e=global:"undefined"!=typeof self&&(e=self),e.buffer=t()}}(function(){return function t(e,n,r){function i(a,u){if(!n[a]){if(!e[a]){var s="function"==typeof require&&require;if(!u&&s)return s(a,!0);if(o)return o(a,!0);throw new Error("Cannot find module '"+a+"'")}var f=n[a]={exports:{}};e[a][0].call(f.exports,function(t){var n=e[a][1][t];return i(n?n:t)},f,f.exports,t,e,n,r)}return n[a].exports}for(var o="function"==typeof require&&require,a=0;a<r.length;a++)i(r[a]);return i}({1:[function(t,e,n){function r(t,e,n){if(!(this instanceof r))return new r(t,e,n);var i=typeof t;if("base64"===e&&"string"===i)for(t=C(t);t.length%4!==0;)t+="=";var o;if("number"===i)o=T(t);else if("string"===i)o=r.byteLength(t,e);else{if("object"!==i)throw new Error("First argument needs to be a number, array or string.");o=T(t.length)}var a;r._useTypedArrays?a=r._augment(new Uint8Array(o)):(a=this,a.length=o,a._isBuffer=!0);var u;if(r._useTypedArrays&&"number"==typeof t.byteLength)a._set(t);else if(M(t))for(u=0;o>u;u++)a[u]=r.isBuffer(t)?t.readUInt8(u):t[u];else if("string"===i)a.write(t,0,e);else if("number"===i&&!r._useTypedArrays&&!n)for(u=0;o>u;u++)a[u]=0;return a}function i(t,e,n,i){n=Number(n)||0;var o=t.length-n;i?(i=Number(i),i>o&&(i=o)):i=o;var a=e.length;R(a%2===0,"Invalid hex string"),i>a/2&&(i=a/2);for(var u=0;i>u;u++){var s=parseInt(e.substr(2*u,2),16);R(!isNaN(s),"Invalid hex string"),t[n+u]=s}return r._charsWritten=2*u,u}function o(t,e,n,i){var o=r._charsWritten=W(x(e),t,n,i);return o}function a(t,e,n,i){var o=r._charsWritten=W(F(e),t,n,i);return o}function u(t,e,n,r){return a(t,e,n,r)}function s(t,e,n,i){var o=r._charsWritten=W(j(e),t,n,i);return o}function f(t,e,n,i){var o=r._charsWritten=W(D(e),t,n,i);return o}function l(t,e,n){return X.fromByteArray(0===e&&n===t.length?t:t.slice(e,n))}function h(t,e,n){var r="",i="";n=Math.min(t.length,n);for(var o=e;n>o;o++)t[o]<=127?(r+=q(i)+String.fromCharCode(t[o]),i=""):i+="%"+t[o].toString(16);return r+q(i)}function c(t,e,n){var r="";n=Math.min(t.length,n);for(var i=e;n>i;i++)r+=String.fromCharCode(t[i]);return r}function g(t,e,n){return c(t,e,n)}function d(t,e,n){var r=t.length;(!e||0>e)&&(e=0),(!n||0>n||n>r)&&(n=r);for(var i="",o=e;n>o;o++)i+=N(t[o]);return i}function p(t,e,n){for(var r=t.slice(e,n),i="",o=0;o<r.length;o+=2)i+=String.fromCharCode(r[o]+256*r[o+1]);return i}function y(t,e,n,r){r||(R("boolean"==typeof n,"missing or invalid endian"),R(void 0!==e&&null!==e,"missing offset"),R(e+1<t.length,"Trying to read beyond buffer length"));var i=t.length;if(!(e>=i)){var o;return n?(o=t[e],i>e+1&&(o|=t[e+1]<<8)):(o=t[e]<<8,i>e+1&&(o|=t[e+1])),o}}function v(t,e,n,r){r||(R("boolean"==typeof n,"missing or invalid endian"),R(void 0!==e&&null!==e,"missing offset"),R(e+3<t.length,"Trying to read beyond buffer length"));var i=t.length;if(!(e>=i)){var o;return n?(i>e+2&&(o=t[e+2]<<16),i>e+1&&(o|=t[e+1]<<8),o|=t[e],i>e+3&&(o+=t[e+3]<<24>>>0)):(i>e+1&&(o=t[e+1]<<16),i>e+2&&(o|=t[e+2]<<8),i>e+3&&(o|=t[e+3]),o+=t[e]<<24>>>0),o}}function b(t,e,n,r){r||(R("boolean"==typeof n,"missing or invalid endian"),R(void 0!==e&&null!==e,"missing offset"),R(e+1<t.length,"Trying to read beyond buffer length"));var i=t.length;if(!(e>=i)){var o=y(t,e,n,!0),a=32768&o;return a?-1*(65535-o+1):o}}function w(t,e,n,r){r||(R("boolean"==typeof n,"missing or invalid endian"),R(void 0!==e&&null!==e,"missing offset"),R(e+3<t.length,"Trying to read beyond buffer length"));var i=t.length;if(!(e>=i)){var o=v(t,e,n,!0),a=2147483648&o;return a?-1*(4294967295-o+1):o}}function m(t,e,n,r){return r||(R("boolean"==typeof n,"missing or invalid endian"),R(e+3<t.length,"Trying to read beyond buffer length")),Y.read(t,e,n,23,4)}function E(t,e,n,r){return r||(R("boolean"==typeof n,"missing or invalid endian"),R(e+7<t.length,"Trying to read beyond buffer length")),Y.read(t,e,n,52,8)}function I(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+1<t.length,"trying to write beyond buffer length"),O(e,65535));var o=t.length;if(!(n>=o))for(var a=0,u=Math.min(o-n,2);u>a;a++)t[n+a]=(e&255<<8*(r?a:1-a))>>>8*(r?a:1-a)}function B(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+3<t.length,"trying to write beyond buffer length"),O(e,4294967295));var o=t.length;if(!(n>=o))for(var a=0,u=Math.min(o-n,4);u>a;a++)t[n+a]=e>>>8*(r?a:3-a)&255}function A(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+1<t.length,"Trying to write beyond buffer length"),J(e,32767,-32768));var o=t.length;n>=o||(e>=0?I(t,e,n,r,i):I(t,65535+e+1,n,r,i))}function U(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+3<t.length,"Trying to write beyond buffer length"),J(e,2147483647,-2147483648));var o=t.length;n>=o||(e>=0?B(t,e,n,r,i):B(t,4294967295+e+1,n,r,i))}function L(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+3<t.length,"Trying to write beyond buffer length"),P(e,3.4028234663852886e38,-3.4028234663852886e38));var o=t.length;n>=o||Y.write(t,e,n,r,23,4)}function S(t,e,n,r,i){i||(R(void 0!==e&&null!==e,"missing value"),R("boolean"==typeof r,"missing or invalid endian"),R(void 0!==n&&null!==n,"missing offset"),R(n+7<t.length,"Trying to write beyond buffer length"),P(e,1.7976931348623157e308,-1.7976931348623157e308));var o=t.length;n>=o||Y.write(t,e,n,r,52,8)}function C(t){return t.trim?t.trim():t.replace(/^\s+|\s+$/g,"")}function _(t,e,n){return"number"!=typeof t?n:(t=~~t,t>=e?e:t>=0?t:(t+=e,t>=0?t:0))}function T(t){return t=~~Math.ceil(+t),0>t?0:t}function k(t){return(Array.isArray||function(t){return"[object Array]"===Object.prototype.toString.call(t)})(t)}function M(t){return k(t)||r.isBuffer(t)||t&&"object"==typeof t&&"number"==typeof t.length}function N(t){return 16>t?"0"+t.toString(16):t.toString(16)}function x(t){for(var e=[],n=0;n<t.length;n++){var r=t.charCodeAt(n);if(127>=r)e.push(t.charCodeAt(n));else{var i=n;r>=55296&&57343>=r&&n++;for(var o=encodeURIComponent(t.slice(i,n+1)).substr(1).split("%"),a=0;a<o.length;a++)e.push(parseInt(o[a],16))}}return e}function F(t){for(var e=[],n=0;n<t.length;n++)e.push(255&t.charCodeAt(n));return e}function D(t){for(var e,n,r,i=[],o=0;o<t.length;o++)e=t.charCodeAt(o),n=e>>8,r=e%256,i.push(r),i.push(n);return i}function j(t){return X.toByteArray(t)}function W(t,e,n,r){for(var i=0;r>i&&!(i+n>=e.length||i>=t.length);i++)e[i+n]=t[i];return i}function q(t){try{return decodeURIComponent(t)}catch(e){return String.fromCharCode(65533)}}function O(t,e){R("number"==typeof t,"cannot write a non-number as a number"),R(t>=0,"specified a negative value for writing an unsigned value"),R(e>=t,"value is larger than maximum value for type"),R(Math.floor(t)===t,"value has a fractional component")}function J(t,e,n){R("number"==typeof t,"cannot write a non-number as a number"),R(e>=t,"value larger than maximum allowed value"),R(t>=n,"value smaller than minimum allowed value"),R(Math.floor(t)===t,"value has a fractional component")}function P(t,e,n){R("number"==typeof t,"cannot write a non-number as a number"),R(e>=t,"value larger than maximum allowed value"),R(t>=n,"value smaller than minimum allowed value")}function R(t,e){if(!t)throw new Error(e||"Failed assertion")}var X=t("base64-js"),Y=t("ieee754");n.Buffer=r,n.SlowBuffer=r,n.INSPECT_MAX_BYTES=50,r.poolSize=8192,r._useTypedArrays=function(){try{var t=new ArrayBuffer(0),e=new Uint8Array(t);return e.foo=function(){return 42},42===e.foo()&&"function"==typeof e.subarray}catch(n){return!1}}(),r.isEncoding=function(t){switch(String(t).toLowerCase()){case"hex":case"utf8":case"utf-8":case"ascii":case"binary":case"base64":case"raw":case"ucs2":case"ucs-2":case"utf16le":case"utf-16le":return!0;default:return!1}},r.isBuffer=function(t){return!(null===t||void 0===t||!t._isBuffer)},r.byteLength=function(t,e){var n;switch(t+="",e||"utf8"){case"hex":n=t.length/2;break;case"utf8":case"utf-8":n=x(t).length;break;case"ascii":case"binary":case"raw":n=t.length;break;case"base64":n=j(t).length;break;case"ucs2":case"ucs-2":case"utf16le":case"utf-16le":n=2*t.length;break;default:throw new Error("Unknown encoding")}return n},r.concat=function(t,e){if(R(k(t),"Usage: Buffer.concat(list, [totalLength])\nlist should be an Array."),0===t.length)return new r(0);if(1===t.length)return t[0];var n;if("number"!=typeof e)for(e=0,n=0;n<t.length;n++)e+=t[n].length;var i=new r(e),o=0;for(n=0;n<t.length;n++){var a=t[n];a.copy(i,o),o+=a.length}return i},r.prototype.write=function(t,e,n,r){if(isFinite(e))isFinite(n)||(r=n,n=void 0);else{var l=r;r=e,e=n,n=l}e=Number(e)||0;var h=this.length-e;n?(n=Number(n),n>h&&(n=h)):n=h,r=String(r||"utf8").toLowerCase();var c;switch(r){case"hex":c=i(this,t,e,n);break;case"utf8":case"utf-8":c=o(this,t,e,n);break;case"ascii":c=a(this,t,e,n);break;case"binary":c=u(this,t,e,n);break;case"base64":c=s(this,t,e,n);break;case"ucs2":case"ucs-2":case"utf16le":case"utf-16le":c=f(this,t,e,n);break;default:throw new Error("Unknown encoding")}return c},r.prototype.toString=function(t,e,n){var r=this;if(t=String(t||"utf8").toLowerCase(),e=Number(e)||0,n=void 0!==n?Number(n):n=r.length,n===e)return"";var i;switch(t){case"hex":i=d(r,e,n);break;case"utf8":case"utf-8":i=h(r,e,n);break;case"ascii":i=c(r,e,n);break;case"binary":i=g(r,e,n);break;case"base64":i=l(r,e,n);break;case"ucs2":case"ucs-2":case"utf16le":case"utf-16le":i=p(r,e,n);break;default:throw new Error("Unknown encoding")}return i},r.prototype.toJSON=function(){return{type:"Buffer",data:Array.prototype.slice.call(this._arr||this,0)}},r.prototype.copy=function(t,e,n,i){var o=this;if(n||(n=0),i||0===i||(i=this.length),e||(e=0),i!==n&&0!==t.length&&0!==o.length){R(i>=n,"sourceEnd < sourceStart"),R(e>=0&&e<t.length,"targetStart out of bounds"),R(n>=0&&n<o.length,"sourceStart out of bounds"),R(i>=0&&i<=o.length,"sourceEnd out of bounds"),i>this.length&&(i=this.length),t.length-e<i-n&&(i=t.length-e+n);var a=i-n;if(100>a||!r._useTypedArrays)for(var u=0;a>u;u++)t[u+e]=this[u+n];else t._set(this.subarray(n,n+a),e)}},r.prototype.slice=function(t,e){var n=this.length;if(t=_(t,n,0),e=_(e,n,n),r._useTypedArrays)return r._augment(this.subarray(t,e));for(var i=e-t,o=new r(i,void 0,!0),a=0;i>a;a++)o[a]=this[a+t];return o},r.prototype.get=function(t){return console.log(".get() is deprecated. Access using array indexes instead."),this.readUInt8(t)},r.prototype.set=function(t,e){return console.log(".set() is deprecated. Access using array indexes instead."),this.writeUInt8(t,e)},r.prototype.readUInt8=function(t,e){return e||(R(void 0!==t&&null!==t,"missing offset"),R(t<this.length,"Trying to read beyond buffer length")),t>=this.length?void 0:this[t]},r.prototype.readUInt16LE=function(t,e){return y(this,t,!0,e)},r.prototype.readUInt16BE=function(t,e){return y(this,t,!1,e)},r.prototype.readUInt32LE=function(t,e){return v(this,t,!0,e)},r.prototype.readUInt32BE=function(t,e){return v(this,t,!1,e)},r.prototype.readInt8=function(t,e){if(e||(R(void 0!==t&&null!==t,"missing offset"),R(t<this.length,"Trying to read beyond buffer length")),!(t>=this.length)){var n=128&this[t];return n?-1*(255-this[t]+1):this[t]}},r.prototype.readInt16LE=function(t,e){return b(this,t,!0,e)},r.prototype.readInt16BE=function(t,e){return b(this,t,!1,e)},r.prototype.readInt32LE=function(t,e){return w(this,t,!0,e)},r.prototype.readInt32BE=function(t,e){return w(this,t,!1,e)},r.prototype.readFloatLE=function(t,e){return m(this,t,!0,e)},r.prototype.readFloatBE=function(t,e){return m(this,t,!1,e)},r.prototype.readDoubleLE=function(t,e){return E(this,t,!0,e)},r.prototype.readDoubleBE=function(t,e){return E(this,t,!1,e)},r.prototype.writeUInt8=function(t,e,n){n||(R(void 0!==t&&null!==t,"missing value"),R(void 0!==e&&null!==e,"missing offset"),R(e<this.length,"trying to write beyond buffer length"),O(t,255)),e>=this.length||(this[e]=t)},r.prototype.writeUInt16LE=function(t,e,n){I(this,t,e,!0,n)},r.prototype.writeUInt16BE=function(t,e,n){I(this,t,e,!1,n)},r.prototype.writeUInt32LE=function(t,e,n){B(this,t,e,!0,n)},r.prototype.writeUInt32BE=function(t,e,n){B(this,t,e,!1,n)},r.prototype.writeInt8=function(t,e,n){n||(R(void 0!==t&&null!==t,"missing value"),R(void 0!==e&&null!==e,"missing offset"),R(e<this.length,"Trying to write beyond buffer length"),J(t,127,-128)),e>=this.length||(t>=0?this.writeUInt8(t,e,n):this.writeUInt8(255+t+1,e,n))},r.prototype.writeInt16LE=function(t,e,n){A(this,t,e,!0,n)},r.prototype.writeInt16BE=function(t,e,n){A(this,t,e,!1,n)},r.prototype.writeInt32LE=function(t,e,n){U(this,t,e,!0,n)},r.prototype.writeInt32BE=function(t,e,n){U(this,t,e,!1,n)},r.prototype.writeFloatLE=function(t,e,n){L(this,t,e,!0,n)},r.prototype.writeFloatBE=function(t,e,n){L(this,t,e,!1,n)},r.prototype.writeDoubleLE=function(t,e,n){S(this,t,e,!0,n)},r.prototype.writeDoubleBE=function(t,e,n){S(this,t,e,!1,n)},r.prototype.fill=function(t,e,n){if(t||(t=0),e||(e=0),n||(n=this.length),"string"==typeof t&&(t=t.charCodeAt(0)),R("number"==typeof t&&!isNaN(t),"value is not a number"),R(n>=e,"end < start"),n!==e&&0!==this.length){R(e>=0&&e<this.length,"start out of bounds"),R(n>=0&&n<=this.length,"end out of bounds");for(var r=e;n>r;r++)this[r]=t}},r.prototype.inspect=function(){for(var t=[],e=this.length,r=0;e>r;r++)if(t[r]=N(this[r]),r===n.INSPECT_MAX_BYTES){t[r+1]="...";break}return"<Buffer "+t.join(" ")+">"},r.prototype.toArrayBuffer=function(){if("undefined"!=typeof Uint8Array){if(r._useTypedArrays)return new r(this).buffer;for(var t=new Uint8Array(this.length),e=0,n=t.length;n>e;e+=1)t[e]=this[e];return t.buffer}throw new Error("Buffer.toArrayBuffer not supported in this browser")};var z=r.prototype;r._augment=function(t){return t._isBuffer=!0,t._get=t.get,t._set=t.set,t.get=z.get,t.set=z.set,t.write=z.write,t.toString=z.toString,t.toLocaleString=z.toString,t.toJSON=z.toJSON,t.copy=z.copy,t.slice=z.slice,t.readUInt8=z.readUInt8,t.readUInt16LE=z.readUInt16LE,t.readUInt16BE=z.readUInt16BE,t.readUInt32LE=z.readUInt32LE,t.readUInt32BE=z.readUInt32BE,t.readInt8=z.readInt8,t.readInt16LE=z.readInt16LE,t.readInt16BE=z.readInt16BE,t.readInt32LE=z.readInt32LE,t.readInt32BE=z.readInt32BE,t.readFloatLE=z.readFloatLE,t.readFloatBE=z.readFloatBE,t.readDoubleLE=z.readDoubleLE,t.readDoubleBE=z.readDoubleBE,t.writeUInt8=z.writeUInt8,t.writeUInt16LE=z.writeUInt16LE,t.writeUInt16BE=z.writeUInt16BE,t.writeUInt32LE=z.writeUInt32LE,t.writeUInt32BE=z.writeUInt32BE,t.writeInt8=z.writeInt8,t.writeInt16LE=z.writeInt16LE,t.writeInt16BE=z.writeInt16BE,t.writeInt32LE=z.writeInt32LE,t.writeInt32BE=z.writeInt32BE,t.writeFloatLE=z.writeFloatLE,t.writeFloatBE=z.writeFloatBE,t.writeDoubleLE=z.writeDoubleLE,t.writeDoubleBE=z.writeDoubleBE,t.fill=z.fill,t.inspect=z.inspect,t.toArrayBuffer=z.toArrayBuffer,t}},{"base64-js":2,ieee754:3}],2:[function(t,e,n){var r="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";!function(t){"use strict";function e(t){var e=t.charCodeAt(0);return e===a?62:e===u?63:s>e?-1:s+10>e?e-s+26+26:l+26>e?e-l:f+26>e?e-f+26:void 0}function n(t){function n(t){f[h++]=t}var r,i,a,u,s,f;if(t.length%4>0)throw new Error("Invalid string. Length must be a multiple of 4");var l=t.length;s="="===t.charAt(l-2)?2:"="===t.charAt(l-1)?1:0,f=new o(3*t.length/4-s),a=s>0?t.length-4:t.length;var h=0;for(r=0,i=0;a>r;r+=4,i+=3)u=e(t.charAt(r))<<18|e(t.charAt(r+1))<<12|e(t.charAt(r+2))<<6|e(t.charAt(r+3)),n((16711680&u)>>16),n((65280&u)>>8),n(255&u);return 2===s?(u=e(t.charAt(r))<<2|e(t.charAt(r+1))>>4,n(255&u)):1===s&&(u=e(t.charAt(r))<<10|e(t.charAt(r+1))<<4|e(t.charAt(r+2))>>2,n(u>>8&255),n(255&u)),f}function i(t){function e(t){return r.charAt(t)}function n(t){return e(t>>18&63)+e(t>>12&63)+e(t>>6&63)+e(63&t)}var i,o,a,u=t.length%3,s="";for(i=0,a=t.length-u;a>i;i+=3)o=(t[i]<<16)+(t[i+1]<<8)+t[i+2],s+=n(o);switch(u){case 1:o=t[t.length-1],s+=e(o>>2),s+=e(o<<4&63),s+="==";break;case 2:o=(t[t.length-2]<<8)+t[t.length-1],s+=e(o>>10),s+=e(o>>4&63),s+=e(o<<2&63),s+="="}return s}var o="undefined"!=typeof Uint8Array?Uint8Array:Array,a="+".charCodeAt(0),u="/".charCodeAt(0),s="0".charCodeAt(0),f="a".charCodeAt(0),l="A".charCodeAt(0);t.toByteArray=n,t.fromByteArray=i}("undefined"==typeof n?this.base64js={}:n)},{}],3:[function(t,e,n){n.read=function(t,e,n,r,i){var o,a,u=8*i-r-1,s=(1<<u)-1,f=s>>1,l=-7,h=n?i-1:0,c=n?-1:1,g=t[e+h];for(h+=c,o=g&(1<<-l)-1,g>>=-l,l+=u;l>0;o=256*o+t[e+h],h+=c,l-=8);for(a=o&(1<<-l)-1,o>>=-l,l+=r;l>0;a=256*a+t[e+h],h+=c,l-=8);if(0===o)o=1-f;else{if(o===s)return a?0/0:1/0*(g?-1:1);a+=Math.pow(2,r),o-=f}return(g?-1:1)*a*Math.pow(2,o-r)},n.write=function(t,e,n,r,i,o){var a,u,s,f=8*o-i-1,l=(1<<f)-1,h=l>>1,c=23===i?Math.pow(2,-24)-Math.pow(2,-77):0,g=r?0:o-1,d=r?1:-1,p=0>e||0===e&&0>1/e?1:0;for(e=Math.abs(e),isNaN(e)||1/0===e?(u=isNaN(e)?1:0,a=l):(a=Math.floor(Math.log(e)/Math.LN2),e*(s=Math.pow(2,-a))<1&&(a--,s*=2),e+=a+h>=1?c/s:c*Math.pow(2,1-h),e*s>=2&&(a++,s/=2),a+h>=l?(u=0,a=l):a+h>=1?(u=(e*s-1)*Math.pow(2,i),a+=h):(u=e*Math.pow(2,h-1)*Math.pow(2,i),a=0));i>=8;t[n+g]=255&u,g+=d,u/=256,i-=8);for(a=a<<i|u,f+=i;f>0;t[n+g]=255&a,g+=d,a/=256,f-=8);t[n+g-d]|=128*p}},{}],4:[function(t,e){e.exports=t("buffer")},{buffer:1}]},{},[4])(4)});

/* pako 0.2.6 nodeca/pako */
!function(t){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=t();else if("function"==typeof define&&define.amd)define([],t);else{var e;e="undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this,e.pako=t()}}(function(){return function t(e,a,i){function n(s,o){if(!a[s]){if(!e[s]){var l="function"==typeof require&&require;if(!o&&l)return l(s,!0);if(r)return r(s,!0);var h=new Error("Cannot find module '"+s+"'");throw h.code="MODULE_NOT_FOUND",h}var d=a[s]={exports:{}};e[s][0].call(d.exports,function(t){var a=e[s][1][t];return n(a?a:t)},d,d.exports,t,e,a,i)}return a[s].exports}for(var r="function"==typeof require&&require,s=0;s<i.length;s++)n(i[s]);return n}({1:[function(t,e,a){"use strict";function i(t,e){var a=new p(e);if(a.push(t,!0),a.err)throw a.msg;return a.result}function n(t,e){return e=e||{},e.raw=!0,i(t,e)}function r(t,e){return e=e||{},e.gzip=!0,i(t,e)}var s=t("./zlib/deflate.js"),o=t("./utils/common"),l=t("./utils/strings"),h=t("./zlib/messages"),d=t("./zlib/zstream"),f=Object.prototype.toString,_=0,u=4,c=0,b=1,g=-1,m=0,w=8,p=function(t){this.options=o.assign({level:g,method:w,chunkSize:16384,windowBits:15,memLevel:8,strategy:m,to:""},t||{});var e=this.options;e.raw&&e.windowBits>0?e.windowBits=-e.windowBits:e.gzip&&e.windowBits>0&&e.windowBits<16&&(e.windowBits+=16),this.err=0,this.msg="",this.ended=!1,this.chunks=[],this.strm=new d,this.strm.avail_out=0;var a=s.deflateInit2(this.strm,e.level,e.method,e.windowBits,e.memLevel,e.strategy);if(a!==c)throw new Error(h[a]);e.header&&s.deflateSetHeader(this.strm,e.header)};p.prototype.push=function(t,e){var a,i,n=this.strm,r=this.options.chunkSize;if(this.ended)return!1;i=e===~~e?e:e===!0?u:_,n.input="string"==typeof t?l.string2buf(t):"[object ArrayBuffer]"===f.call(t)?new Uint8Array(t):t,n.next_in=0,n.avail_in=n.input.length;do{if(0===n.avail_out&&(n.output=new o.Buf8(r),n.next_out=0,n.avail_out=r),a=s.deflate(n,i),a!==b&&a!==c)return this.onEnd(a),this.ended=!0,!1;(0===n.avail_out||0===n.avail_in&&i===u)&&this.onData("string"===this.options.to?l.buf2binstring(o.shrinkBuf(n.output,n.next_out)):o.shrinkBuf(n.output,n.next_out))}while((n.avail_in>0||0===n.avail_out)&&a!==b);return i===u?(a=s.deflateEnd(this.strm),this.onEnd(a),this.ended=!0,a===c):!0},p.prototype.onData=function(t){this.chunks.push(t)},p.prototype.onEnd=function(t){t===c&&(this.result="string"===this.options.to?this.chunks.join(""):o.flattenChunks(this.chunks)),this.chunks=[],this.err=t,this.msg=this.strm.msg},a.Deflate=p,a.deflate=i,a.deflateRaw=n,a.gzip=r},{"./utils/common":3,"./utils/strings":4,"./zlib/deflate.js":8,"./zlib/messages":13,"./zlib/zstream":15}],2:[function(t,e,a){"use strict";function i(t,e){var a=new u(e);if(a.push(t,!0),a.err)throw a.msg;return a.result}function n(t,e){return e=e||{},e.raw=!0,i(t,e)}var r=t("./zlib/inflate.js"),s=t("./utils/common"),o=t("./utils/strings"),l=t("./zlib/constants"),h=t("./zlib/messages"),d=t("./zlib/zstream"),f=t("./zlib/gzheader"),_=Object.prototype.toString,u=function(t){this.options=s.assign({chunkSize:16384,windowBits:0,to:""},t||{});var e=this.options;e.raw&&e.windowBits>=0&&e.windowBits<16&&(e.windowBits=-e.windowBits,0===e.windowBits&&(e.windowBits=-15)),!(e.windowBits>=0&&e.windowBits<16)||t&&t.windowBits||(e.windowBits+=32),e.windowBits>15&&e.windowBits<48&&0===(15&e.windowBits)&&(e.windowBits|=15),this.err=0,this.msg="",this.ended=!1,this.chunks=[],this.strm=new d,this.strm.avail_out=0;var a=r.inflateInit2(this.strm,e.windowBits);if(a!==l.Z_OK)throw new Error(h[a]);this.header=new f,r.inflateGetHeader(this.strm,this.header)};u.prototype.push=function(t,e){var a,i,n,h,d,f=this.strm,u=this.options.chunkSize;if(this.ended)return!1;i=e===~~e?e:e===!0?l.Z_FINISH:l.Z_NO_FLUSH,f.input="string"==typeof t?o.binstring2buf(t):"[object ArrayBuffer]"===_.call(t)?new Uint8Array(t):t,f.next_in=0,f.avail_in=f.input.length;do{if(0===f.avail_out&&(f.output=new s.Buf8(u),f.next_out=0,f.avail_out=u),a=r.inflate(f,l.Z_NO_FLUSH),a!==l.Z_STREAM_END&&a!==l.Z_OK)return this.onEnd(a),this.ended=!0,!1;f.next_out&&(0===f.avail_out||a===l.Z_STREAM_END||0===f.avail_in&&i===l.Z_FINISH)&&("string"===this.options.to?(n=o.utf8border(f.output,f.next_out),h=f.next_out-n,d=o.buf2string(f.output,n),f.next_out=h,f.avail_out=u-h,h&&s.arraySet(f.output,f.output,n,h,0),this.onData(d)):this.onData(s.shrinkBuf(f.output,f.next_out)))}while(f.avail_in>0&&a!==l.Z_STREAM_END);return a===l.Z_STREAM_END&&(i=l.Z_FINISH),i===l.Z_FINISH?(a=r.inflateEnd(this.strm),this.onEnd(a),this.ended=!0,a===l.Z_OK):!0},u.prototype.onData=function(t){this.chunks.push(t)},u.prototype.onEnd=function(t){t===l.Z_OK&&(this.result="string"===this.options.to?this.chunks.join(""):s.flattenChunks(this.chunks)),this.chunks=[],this.err=t,this.msg=this.strm.msg},a.Inflate=u,a.inflate=i,a.inflateRaw=n,a.ungzip=i},{"./utils/common":3,"./utils/strings":4,"./zlib/constants":6,"./zlib/gzheader":9,"./zlib/inflate.js":11,"./zlib/messages":13,"./zlib/zstream":15}],3:[function(t,e,a){"use strict";var i="undefined"!=typeof Uint8Array&&"undefined"!=typeof Uint16Array&&"undefined"!=typeof Int32Array;a.assign=function(t){for(var e=Array.prototype.slice.call(arguments,1);e.length;){var a=e.shift();if(a){if("object"!=typeof a)throw new TypeError(a+"must be non-object");for(var i in a)a.hasOwnProperty(i)&&(t[i]=a[i])}}return t},a.shrinkBuf=function(t,e){return t.length===e?t:t.subarray?t.subarray(0,e):(t.length=e,t)};var n={arraySet:function(t,e,a,i,n){if(e.subarray&&t.subarray)return void t.set(e.subarray(a,a+i),n);for(var r=0;i>r;r++)t[n+r]=e[a+r]},flattenChunks:function(t){var e,a,i,n,r,s;for(i=0,e=0,a=t.length;a>e;e++)i+=t[e].length;for(s=new Uint8Array(i),n=0,e=0,a=t.length;a>e;e++)r=t[e],s.set(r,n),n+=r.length;return s}},r={arraySet:function(t,e,a,i,n){for(var r=0;i>r;r++)t[n+r]=e[a+r]},flattenChunks:function(t){return[].concat.apply([],t)}};a.setTyped=function(t){t?(a.Buf8=Uint8Array,a.Buf16=Uint16Array,a.Buf32=Int32Array,a.assign(a,n)):(a.Buf8=Array,a.Buf16=Array,a.Buf32=Array,a.assign(a,r))},a.setTyped(i)},{}],4:[function(t,e,a){"use strict";function i(t,e){if(65537>e&&(t.subarray&&s||!t.subarray&&r))return String.fromCharCode.apply(null,n.shrinkBuf(t,e));for(var a="",i=0;e>i;i++)a+=String.fromCharCode(t[i]);return a}var n=t("./common"),r=!0,s=!0;try{String.fromCharCode.apply(null,[0])}catch(o){r=!1}try{String.fromCharCode.apply(null,new Uint8Array(1))}catch(o){s=!1}for(var l=new n.Buf8(256),h=0;256>h;h++)l[h]=h>=252?6:h>=248?5:h>=240?4:h>=224?3:h>=192?2:1;l[254]=l[254]=1,a.string2buf=function(t){var e,a,i,r,s,o=t.length,l=0;for(r=0;o>r;r++)a=t.charCodeAt(r),55296===(64512&a)&&o>r+1&&(i=t.charCodeAt(r+1),56320===(64512&i)&&(a=65536+(a-55296<<10)+(i-56320),r++)),l+=128>a?1:2048>a?2:65536>a?3:4;for(e=new n.Buf8(l),s=0,r=0;l>s;r++)a=t.charCodeAt(r),55296===(64512&a)&&o>r+1&&(i=t.charCodeAt(r+1),56320===(64512&i)&&(a=65536+(a-55296<<10)+(i-56320),r++)),128>a?e[s++]=a:2048>a?(e[s++]=192|a>>>6,e[s++]=128|63&a):65536>a?(e[s++]=224|a>>>12,e[s++]=128|a>>>6&63,e[s++]=128|63&a):(e[s++]=240|a>>>18,e[s++]=128|a>>>12&63,e[s++]=128|a>>>6&63,e[s++]=128|63&a);return e},a.buf2binstring=function(t){return i(t,t.length)},a.binstring2buf=function(t){for(var e=new n.Buf8(t.length),a=0,i=e.length;i>a;a++)e[a]=t.charCodeAt(a);return e},a.buf2string=function(t,e){var a,n,r,s,o=e||t.length,h=new Array(2*o);for(n=0,a=0;o>a;)if(r=t[a++],128>r)h[n++]=r;else if(s=l[r],s>4)h[n++]=65533,a+=s-1;else{for(r&=2===s?31:3===s?15:7;s>1&&o>a;)r=r<<6|63&t[a++],s--;s>1?h[n++]=65533:65536>r?h[n++]=r:(r-=65536,h[n++]=55296|r>>10&1023,h[n++]=56320|1023&r)}return i(h,n)},a.utf8border=function(t,e){var a;for(e=e||t.length,e>t.length&&(e=t.length),a=e-1;a>=0&&128===(192&t[a]);)a--;return 0>a?e:0===a?e:a+l[t[a]]>e?a:e}},{"./common":3}],5:[function(t,e){"use strict";function a(t,e,a,i){for(var n=65535&t|0,r=t>>>16&65535|0,s=0;0!==a;){s=a>2e3?2e3:a,a-=s;do n=n+e[i++]|0,r=r+n|0;while(--s);n%=65521,r%=65521}return n|r<<16|0}e.exports=a},{}],6:[function(t,e){e.exports={Z_NO_FLUSH:0,Z_PARTIAL_FLUSH:1,Z_SYNC_FLUSH:2,Z_FULL_FLUSH:3,Z_FINISH:4,Z_BLOCK:5,Z_TREES:6,Z_OK:0,Z_STREAM_END:1,Z_NEED_DICT:2,Z_ERRNO:-1,Z_STREAM_ERROR:-2,Z_DATA_ERROR:-3,Z_BUF_ERROR:-5,Z_NO_COMPRESSION:0,Z_BEST_SPEED:1,Z_BEST_COMPRESSION:9,Z_DEFAULT_COMPRESSION:-1,Z_FILTERED:1,Z_HUFFMAN_ONLY:2,Z_RLE:3,Z_FIXED:4,Z_DEFAULT_STRATEGY:0,Z_BINARY:0,Z_TEXT:1,Z_UNKNOWN:2,Z_DEFLATED:8}},{}],7:[function(t,e){"use strict";function a(){for(var t,e=[],a=0;256>a;a++){t=a;for(var i=0;8>i;i++)t=1&t?3988292384^t>>>1:t>>>1;e[a]=t}return e}function i(t,e,a,i){var r=n,s=i+a;t=-1^t;for(var o=i;s>o;o++)t=t>>>8^r[255&(t^e[o])];return-1^t}var n=a();e.exports=i},{}],8:[function(t,e,a){"use strict";function i(t,e){return t.msg=N[e],e}function n(t){return(t<<1)-(t>4?9:0)}function r(t){for(var e=t.length;--e>=0;)t[e]=0}function s(t){var e=t.state,a=e.pending;a>t.avail_out&&(a=t.avail_out),0!==a&&(A.arraySet(t.output,e.pending_buf,e.pending_out,a,t.next_out),t.next_out+=a,e.pending_out+=a,t.total_out+=a,t.avail_out-=a,e.pending-=a,0===e.pending&&(e.pending_out=0))}function o(t,e){Z._tr_flush_block(t,t.block_start>=0?t.block_start:-1,t.strstart-t.block_start,e),t.block_start=t.strstart,s(t.strm)}function l(t,e){t.pending_buf[t.pending++]=e}function h(t,e){t.pending_buf[t.pending++]=e>>>8&255,t.pending_buf[t.pending++]=255&e}function d(t,e,a,i){var n=t.avail_in;return n>i&&(n=i),0===n?0:(t.avail_in-=n,A.arraySet(e,t.input,t.next_in,n,a),1===t.state.wrap?t.adler=R(t.adler,e,n,a):2===t.state.wrap&&(t.adler=C(t.adler,e,n,a)),t.next_in+=n,t.total_in+=n,n)}function f(t,e){var a,i,n=t.max_chain_length,r=t.strstart,s=t.prev_length,o=t.nice_match,l=t.strstart>t.w_size-ht?t.strstart-(t.w_size-ht):0,h=t.window,d=t.w_mask,f=t.prev,_=t.strstart+lt,u=h[r+s-1],c=h[r+s];t.prev_length>=t.good_match&&(n>>=2),o>t.lookahead&&(o=t.lookahead);do if(a=e,h[a+s]===c&&h[a+s-1]===u&&h[a]===h[r]&&h[++a]===h[r+1]){r+=2,a++;do;while(h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&h[++r]===h[++a]&&_>r);if(i=lt-(_-r),r=_-lt,i>s){if(t.match_start=e,s=i,i>=o)break;u=h[r+s-1],c=h[r+s]}}while((e=f[e&d])>l&&0!==--n);return s<=t.lookahead?s:t.lookahead}function _(t){var e,a,i,n,r,s=t.w_size;do{if(n=t.window_size-t.lookahead-t.strstart,t.strstart>=s+(s-ht)){A.arraySet(t.window,t.window,s,s,0),t.match_start-=s,t.strstart-=s,t.block_start-=s,a=t.hash_size,e=a;do i=t.head[--e],t.head[e]=i>=s?i-s:0;while(--a);a=s,e=a;do i=t.prev[--e],t.prev[e]=i>=s?i-s:0;while(--a);n+=s}if(0===t.strm.avail_in)break;if(a=d(t.strm,t.window,t.strstart+t.lookahead,n),t.lookahead+=a,t.lookahead+t.insert>=ot)for(r=t.strstart-t.insert,t.ins_h=t.window[r],t.ins_h=(t.ins_h<<t.hash_shift^t.window[r+1])&t.hash_mask;t.insert&&(t.ins_h=(t.ins_h<<t.hash_shift^t.window[r+ot-1])&t.hash_mask,t.prev[r&t.w_mask]=t.head[t.ins_h],t.head[t.ins_h]=r,r++,t.insert--,!(t.lookahead+t.insert<ot)););}while(t.lookahead<ht&&0!==t.strm.avail_in)}function u(t,e){var a=65535;for(a>t.pending_buf_size-5&&(a=t.pending_buf_size-5);;){if(t.lookahead<=1){if(_(t),0===t.lookahead&&e===I)return wt;if(0===t.lookahead)break}t.strstart+=t.lookahead,t.lookahead=0;var i=t.block_start+a;if((0===t.strstart||t.strstart>=i)&&(t.lookahead=t.strstart-i,t.strstart=i,o(t,!1),0===t.strm.avail_out))return wt;if(t.strstart-t.block_start>=t.w_size-ht&&(o(t,!1),0===t.strm.avail_out))return wt}return t.insert=0,e===D?(o(t,!0),0===t.strm.avail_out?vt:kt):t.strstart>t.block_start&&(o(t,!1),0===t.strm.avail_out)?wt:wt}function c(t,e){for(var a,i;;){if(t.lookahead<ht){if(_(t),t.lookahead<ht&&e===I)return wt;if(0===t.lookahead)break}if(a=0,t.lookahead>=ot&&(t.ins_h=(t.ins_h<<t.hash_shift^t.window[t.strstart+ot-1])&t.hash_mask,a=t.prev[t.strstart&t.w_mask]=t.head[t.ins_h],t.head[t.ins_h]=t.strstart),0!==a&&t.strstart-a<=t.w_size-ht&&(t.match_length=f(t,a)),t.match_length>=ot)if(i=Z._tr_tally(t,t.strstart-t.match_start,t.match_length-ot),t.lookahead-=t.match_length,t.match_length<=t.max_lazy_match&&t.lookahead>=ot){t.match_length--;do t.strstart++,t.ins_h=(t.ins_h<<t.hash_shift^t.window[t.strstart+ot-1])&t.hash_mask,a=t.prev[t.strstart&t.w_mask]=t.head[t.ins_h],t.head[t.ins_h]=t.strstart;while(0!==--t.match_length);t.strstart++}else t.strstart+=t.match_length,t.match_length=0,t.ins_h=t.window[t.strstart],t.ins_h=(t.ins_h<<t.hash_shift^t.window[t.strstart+1])&t.hash_mask;else i=Z._tr_tally(t,0,t.window[t.strstart]),t.lookahead--,t.strstart++;if(i&&(o(t,!1),0===t.strm.avail_out))return wt}return t.insert=t.strstart<ot-1?t.strstart:ot-1,e===D?(o(t,!0),0===t.strm.avail_out?vt:kt):t.last_lit&&(o(t,!1),0===t.strm.avail_out)?wt:pt}function b(t,e){for(var a,i,n;;){if(t.lookahead<ht){if(_(t),t.lookahead<ht&&e===I)return wt;if(0===t.lookahead)break}if(a=0,t.lookahead>=ot&&(t.ins_h=(t.ins_h<<t.hash_shift^t.window[t.strstart+ot-1])&t.hash_mask,a=t.prev[t.strstart&t.w_mask]=t.head[t.ins_h],t.head[t.ins_h]=t.strstart),t.prev_length=t.match_length,t.prev_match=t.match_start,t.match_length=ot-1,0!==a&&t.prev_length<t.max_lazy_match&&t.strstart-a<=t.w_size-ht&&(t.match_length=f(t,a),t.match_length<=5&&(t.strategy===P||t.match_length===ot&&t.strstart-t.match_start>4096)&&(t.match_length=ot-1)),t.prev_length>=ot&&t.match_length<=t.prev_length){n=t.strstart+t.lookahead-ot,i=Z._tr_tally(t,t.strstart-1-t.prev_match,t.prev_length-ot),t.lookahead-=t.prev_length-1,t.prev_length-=2;do++t.strstart<=n&&(t.ins_h=(t.ins_h<<t.hash_shift^t.window[t.strstart+ot-1])&t.hash_mask,a=t.prev[t.strstart&t.w_mask]=t.head[t.ins_h],t.head[t.ins_h]=t.strstart);while(0!==--t.prev_length);if(t.match_available=0,t.match_length=ot-1,t.strstart++,i&&(o(t,!1),0===t.strm.avail_out))return wt}else if(t.match_available){if(i=Z._tr_tally(t,0,t.window[t.strstart-1]),i&&o(t,!1),t.strstart++,t.lookahead--,0===t.strm.avail_out)return wt}else t.match_available=1,t.strstart++,t.lookahead--}return t.match_available&&(i=Z._tr_tally(t,0,t.window[t.strstart-1]),t.match_available=0),t.insert=t.strstart<ot-1?t.strstart:ot-1,e===D?(o(t,!0),0===t.strm.avail_out?vt:kt):t.last_lit&&(o(t,!1),0===t.strm.avail_out)?wt:pt}function g(t,e){for(var a,i,n,r,s=t.window;;){if(t.lookahead<=lt){if(_(t),t.lookahead<=lt&&e===I)return wt;if(0===t.lookahead)break}if(t.match_length=0,t.lookahead>=ot&&t.strstart>0&&(n=t.strstart-1,i=s[n],i===s[++n]&&i===s[++n]&&i===s[++n])){r=t.strstart+lt;do;while(i===s[++n]&&i===s[++n]&&i===s[++n]&&i===s[++n]&&i===s[++n]&&i===s[++n]&&i===s[++n]&&i===s[++n]&&r>n);t.match_length=lt-(r-n),t.match_length>t.lookahead&&(t.match_length=t.lookahead)}if(t.match_length>=ot?(a=Z._tr_tally(t,1,t.match_length-ot),t.lookahead-=t.match_length,t.strstart+=t.match_length,t.match_length=0):(a=Z._tr_tally(t,0,t.window[t.strstart]),t.lookahead--,t.strstart++),a&&(o(t,!1),0===t.strm.avail_out))return wt}return t.insert=0,e===D?(o(t,!0),0===t.strm.avail_out?vt:kt):t.last_lit&&(o(t,!1),0===t.strm.avail_out)?wt:pt}function m(t,e){for(var a;;){if(0===t.lookahead&&(_(t),0===t.lookahead)){if(e===I)return wt;break}if(t.match_length=0,a=Z._tr_tally(t,0,t.window[t.strstart]),t.lookahead--,t.strstart++,a&&(o(t,!1),0===t.strm.avail_out))return wt}return t.insert=0,e===D?(o(t,!0),0===t.strm.avail_out?vt:kt):t.last_lit&&(o(t,!1),0===t.strm.avail_out)?wt:pt}function w(t){t.window_size=2*t.w_size,r(t.head),t.max_lazy_match=E[t.level].max_lazy,t.good_match=E[t.level].good_length,t.nice_match=E[t.level].nice_length,t.max_chain_length=E[t.level].max_chain,t.strstart=0,t.block_start=0,t.lookahead=0,t.insert=0,t.match_length=t.prev_length=ot-1,t.match_available=0,t.ins_h=0}function p(){this.strm=null,this.status=0,this.pending_buf=null,this.pending_buf_size=0,this.pending_out=0,this.pending=0,this.wrap=0,this.gzhead=null,this.gzindex=0,this.method=J,this.last_flush=-1,this.w_size=0,this.w_bits=0,this.w_mask=0,this.window=null,this.window_size=0,this.prev=null,this.head=null,this.ins_h=0,this.hash_size=0,this.hash_bits=0,this.hash_mask=0,this.hash_shift=0,this.block_start=0,this.match_length=0,this.prev_match=0,this.match_available=0,this.strstart=0,this.match_start=0,this.lookahead=0,this.prev_length=0,this.max_chain_length=0,this.max_lazy_match=0,this.level=0,this.strategy=0,this.good_match=0,this.nice_match=0,this.dyn_ltree=new A.Buf16(2*rt),this.dyn_dtree=new A.Buf16(2*(2*it+1)),this.bl_tree=new A.Buf16(2*(2*nt+1)),r(this.dyn_ltree),r(this.dyn_dtree),r(this.bl_tree),this.l_desc=null,this.d_desc=null,this.bl_desc=null,this.bl_count=new A.Buf16(st+1),this.heap=new A.Buf16(2*at+1),r(this.heap),this.heap_len=0,this.heap_max=0,this.depth=new A.Buf16(2*at+1),r(this.depth),this.l_buf=0,this.lit_bufsize=0,this.last_lit=0,this.d_buf=0,this.opt_len=0,this.static_len=0,this.matches=0,this.insert=0,this.bi_buf=0,this.bi_valid=0}function v(t){var e;return t&&t.state?(t.total_in=t.total_out=0,t.data_type=W,e=t.state,e.pending=0,e.pending_out=0,e.wrap<0&&(e.wrap=-e.wrap),e.status=e.wrap?ft:gt,t.adler=2===e.wrap?0:1,e.last_flush=I,Z._tr_init(e),F):i(t,H)}function k(t){var e=v(t);return e===F&&w(t.state),e}function x(t,e){return t&&t.state?2!==t.state.wrap?H:(t.state.gzhead=e,F):H}function y(t,e,a,n,r,s){if(!t)return H;var o=1;if(e===K&&(e=6),0>n?(o=0,n=-n):n>15&&(o=2,n-=16),1>r||r>Q||a!==J||8>n||n>15||0>e||e>9||0>s||s>G)return i(t,H);8===n&&(n=9);var l=new p;return t.state=l,l.strm=t,l.wrap=o,l.gzhead=null,l.w_bits=n,l.w_size=1<<l.w_bits,l.w_mask=l.w_size-1,l.hash_bits=r+7,l.hash_size=1<<l.hash_bits,l.hash_mask=l.hash_size-1,l.hash_shift=~~((l.hash_bits+ot-1)/ot),l.window=new A.Buf8(2*l.w_size),l.head=new A.Buf16(l.hash_size),l.prev=new A.Buf16(l.w_size),l.lit_bufsize=1<<r+6,l.pending_buf_size=4*l.lit_bufsize,l.pending_buf=new A.Buf8(l.pending_buf_size),l.d_buf=l.lit_bufsize>>1,l.l_buf=3*l.lit_bufsize,l.level=e,l.strategy=s,l.method=a,k(t)}function z(t,e){return y(t,e,J,V,$,X)}function B(t,e){var a,o,d,f;if(!t||!t.state||e>U||0>e)return t?i(t,H):H;if(o=t.state,!t.output||!t.input&&0!==t.avail_in||o.status===mt&&e!==D)return i(t,0===t.avail_out?M:H);if(o.strm=t,a=o.last_flush,o.last_flush=e,o.status===ft)if(2===o.wrap)t.adler=0,l(o,31),l(o,139),l(o,8),o.gzhead?(l(o,(o.gzhead.text?1:0)+(o.gzhead.hcrc?2:0)+(o.gzhead.extra?4:0)+(o.gzhead.name?8:0)+(o.gzhead.comment?16:0)),l(o,255&o.gzhead.time),l(o,o.gzhead.time>>8&255),l(o,o.gzhead.time>>16&255),l(o,o.gzhead.time>>24&255),l(o,9===o.level?2:o.strategy>=q||o.level<2?4:0),l(o,255&o.gzhead.os),o.gzhead.extra&&o.gzhead.extra.length&&(l(o,255&o.gzhead.extra.length),l(o,o.gzhead.extra.length>>8&255)),o.gzhead.hcrc&&(t.adler=C(t.adler,o.pending_buf,o.pending,0)),o.gzindex=0,o.status=_t):(l(o,0),l(o,0),l(o,0),l(o,0),l(o,0),l(o,9===o.level?2:o.strategy>=q||o.level<2?4:0),l(o,xt),o.status=gt);else{var _=J+(o.w_bits-8<<4)<<8,u=-1;u=o.strategy>=q||o.level<2?0:o.level<6?1:6===o.level?2:3,_|=u<<6,0!==o.strstart&&(_|=dt),_+=31-_%31,o.status=gt,h(o,_),0!==o.strstart&&(h(o,t.adler>>>16),h(o,65535&t.adler)),t.adler=1}if(o.status===_t)if(o.gzhead.extra){for(d=o.pending;o.gzindex<(65535&o.gzhead.extra.length)&&(o.pending!==o.pending_buf_size||(o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),s(t),d=o.pending,o.pending!==o.pending_buf_size));)l(o,255&o.gzhead.extra[o.gzindex]),o.gzindex++;o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),o.gzindex===o.gzhead.extra.length&&(o.gzindex=0,o.status=ut)}else o.status=ut;if(o.status===ut)if(o.gzhead.name){d=o.pending;do{if(o.pending===o.pending_buf_size&&(o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),s(t),d=o.pending,o.pending===o.pending_buf_size)){f=1;break}f=o.gzindex<o.gzhead.name.length?255&o.gzhead.name.charCodeAt(o.gzindex++):0,l(o,f)}while(0!==f);o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),0===f&&(o.gzindex=0,o.status=ct)}else o.status=ct;if(o.status===ct)if(o.gzhead.comment){d=o.pending;do{if(o.pending===o.pending_buf_size&&(o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),s(t),d=o.pending,o.pending===o.pending_buf_size)){f=1;break}f=o.gzindex<o.gzhead.comment.length?255&o.gzhead.comment.charCodeAt(o.gzindex++):0,l(o,f)}while(0!==f);o.gzhead.hcrc&&o.pending>d&&(t.adler=C(t.adler,o.pending_buf,o.pending-d,d)),0===f&&(o.status=bt)}else o.status=bt;if(o.status===bt&&(o.gzhead.hcrc?(o.pending+2>o.pending_buf_size&&s(t),o.pending+2<=o.pending_buf_size&&(l(o,255&t.adler),l(o,t.adler>>8&255),t.adler=0,o.status=gt)):o.status=gt),0!==o.pending){if(s(t),0===t.avail_out)return o.last_flush=-1,F}else if(0===t.avail_in&&n(e)<=n(a)&&e!==D)return i(t,M);if(o.status===mt&&0!==t.avail_in)return i(t,M);if(0!==t.avail_in||0!==o.lookahead||e!==I&&o.status!==mt){var c=o.strategy===q?m(o,e):o.strategy===Y?g(o,e):E[o.level].func(o,e);if((c===vt||c===kt)&&(o.status=mt),c===wt||c===vt)return 0===t.avail_out&&(o.last_flush=-1),F;if(c===pt&&(e===O?Z._tr_align(o):e!==U&&(Z._tr_stored_block(o,0,0,!1),e===T&&(r(o.head),0===o.lookahead&&(o.strstart=0,o.block_start=0,o.insert=0))),s(t),0===t.avail_out))return o.last_flush=-1,F}return e!==D?F:o.wrap<=0?L:(2===o.wrap?(l(o,255&t.adler),l(o,t.adler>>8&255),l(o,t.adler>>16&255),l(o,t.adler>>24&255),l(o,255&t.total_in),l(o,t.total_in>>8&255),l(o,t.total_in>>16&255),l(o,t.total_in>>24&255)):(h(o,t.adler>>>16),h(o,65535&t.adler)),s(t),o.wrap>0&&(o.wrap=-o.wrap),0!==o.pending?F:L)}function S(t){var e;return t&&t.state?(e=t.state.status,e!==ft&&e!==_t&&e!==ut&&e!==ct&&e!==bt&&e!==gt&&e!==mt?i(t,H):(t.state=null,e===gt?i(t,j):F)):H}var E,A=t("../utils/common"),Z=t("./trees"),R=t("./adler32"),C=t("./crc32"),N=t("./messages"),I=0,O=1,T=3,D=4,U=5,F=0,L=1,H=-2,j=-3,M=-5,K=-1,P=1,q=2,Y=3,G=4,X=0,W=2,J=8,Q=9,V=15,$=8,tt=29,et=256,at=et+1+tt,it=30,nt=19,rt=2*at+1,st=15,ot=3,lt=258,ht=lt+ot+1,dt=32,ft=42,_t=69,ut=73,ct=91,bt=103,gt=113,mt=666,wt=1,pt=2,vt=3,kt=4,xt=3,yt=function(t,e,a,i,n){this.good_length=t,this.max_lazy=e,this.nice_length=a,this.max_chain=i,this.func=n};E=[new yt(0,0,0,0,u),new yt(4,4,8,4,c),new yt(4,5,16,8,c),new yt(4,6,32,32,c),new yt(4,4,16,16,b),new yt(8,16,32,32,b),new yt(8,16,128,128,b),new yt(8,32,128,256,b),new yt(32,128,258,1024,b),new yt(32,258,258,4096,b)],a.deflateInit=z,a.deflateInit2=y,a.deflateReset=k,a.deflateResetKeep=v,a.deflateSetHeader=x,a.deflate=B,a.deflateEnd=S,a.deflateInfo="pako deflate (from Nodeca project)"},{"../utils/common":3,"./adler32":5,"./crc32":7,"./messages":13,"./trees":14}],9:[function(t,e){"use strict";function a(){this.text=0,this.time=0,this.xflags=0,this.os=0,this.extra=null,this.extra_len=0,this.name="",this.comment="",this.hcrc=0,this.done=!1}e.exports=a},{}],10:[function(t,e){"use strict";var a=30,i=12;e.exports=function(t,e){var n,r,s,o,l,h,d,f,_,u,c,b,g,m,w,p,v,k,x,y,z,B,S,E,A;n=t.state,r=t.next_in,E=t.input,s=r+(t.avail_in-5),o=t.next_out,A=t.output,l=o-(e-t.avail_out),h=o+(t.avail_out-257),d=n.dmax,f=n.wsize,_=n.whave,u=n.wnext,c=n.window,b=n.hold,g=n.bits,m=n.lencode,w=n.distcode,p=(1<<n.lenbits)-1,v=(1<<n.distbits)-1;t:do{15>g&&(b+=E[r++]<<g,g+=8,b+=E[r++]<<g,g+=8),k=m[b&p];e:for(;;){if(x=k>>>24,b>>>=x,g-=x,x=k>>>16&255,0===x)A[o++]=65535&k;else{if(!(16&x)){if(0===(64&x)){k=m[(65535&k)+(b&(1<<x)-1)];continue e}if(32&x){n.mode=i;break t}t.msg="invalid literal/length code",n.mode=a;break t}y=65535&k,x&=15,x&&(x>g&&(b+=E[r++]<<g,g+=8),y+=b&(1<<x)-1,b>>>=x,g-=x),15>g&&(b+=E[r++]<<g,g+=8,b+=E[r++]<<g,g+=8),k=w[b&v];a:for(;;){if(x=k>>>24,b>>>=x,g-=x,x=k>>>16&255,!(16&x)){if(0===(64&x)){k=w[(65535&k)+(b&(1<<x)-1)];continue a}t.msg="invalid distance code",n.mode=a;break t}if(z=65535&k,x&=15,x>g&&(b+=E[r++]<<g,g+=8,x>g&&(b+=E[r++]<<g,g+=8)),z+=b&(1<<x)-1,z>d){t.msg="invalid distance too far back",n.mode=a;break t}if(b>>>=x,g-=x,x=o-l,z>x){if(x=z-x,x>_&&n.sane){t.msg="invalid distance too far back",n.mode=a;break t}if(B=0,S=c,0===u){if(B+=f-x,y>x){y-=x;do A[o++]=c[B++];while(--x);B=o-z,S=A}}else if(x>u){if(B+=f+u-x,x-=u,y>x){y-=x;do A[o++]=c[B++];while(--x);if(B=0,y>u){x=u,y-=x;do A[o++]=c[B++];while(--x);B=o-z,S=A}}}else if(B+=u-x,y>x){y-=x;do A[o++]=c[B++];while(--x);B=o-z,S=A}for(;y>2;)A[o++]=S[B++],A[o++]=S[B++],A[o++]=S[B++],y-=3;y&&(A[o++]=S[B++],y>1&&(A[o++]=S[B++]))}else{B=o-z;do A[o++]=A[B++],A[o++]=A[B++],A[o++]=A[B++],y-=3;while(y>2);y&&(A[o++]=A[B++],y>1&&(A[o++]=A[B++]))}break}}break}}while(s>r&&h>o);y=g>>3,r-=y,g-=y<<3,b&=(1<<g)-1,t.next_in=r,t.next_out=o,t.avail_in=s>r?5+(s-r):5-(r-s),t.avail_out=h>o?257+(h-o):257-(o-h),n.hold=b,n.bits=g}},{}],11:[function(t,e,a){"use strict";function i(t){return(t>>>24&255)+(t>>>8&65280)+((65280&t)<<8)+((255&t)<<24)}function n(){this.mode=0,this.last=!1,this.wrap=0,this.havedict=!1,this.flags=0,this.dmax=0,this.check=0,this.total=0,this.head=null,this.wbits=0,this.wsize=0,this.whave=0,this.wnext=0,this.window=null,this.hold=0,this.bits=0,this.length=0,this.offset=0,this.extra=0,this.lencode=null,this.distcode=null,this.lenbits=0,this.distbits=0,this.ncode=0,this.nlen=0,this.ndist=0,this.have=0,this.next=null,this.lens=new m.Buf16(320),this.work=new m.Buf16(288),this.lendyn=null,this.distdyn=null,this.sane=0,this.back=0,this.was=0}function r(t){var e;return t&&t.state?(e=t.state,t.total_in=t.total_out=e.total=0,t.msg="",e.wrap&&(t.adler=1&e.wrap),e.mode=D,e.last=0,e.havedict=0,e.dmax=32768,e.head=null,e.hold=0,e.bits=0,e.lencode=e.lendyn=new m.Buf32(ct),e.distcode=e.distdyn=new m.Buf32(bt),e.sane=1,e.back=-1,A):C}function s(t){var e;return t&&t.state?(e=t.state,e.wsize=0,e.whave=0,e.wnext=0,r(t)):C}function o(t,e){var a,i;return t&&t.state?(i=t.state,0>e?(a=0,e=-e):(a=(e>>4)+1,48>e&&(e&=15)),e&&(8>e||e>15)?C:(null!==i.window&&i.wbits!==e&&(i.window=null),i.wrap=a,i.wbits=e,s(t))):C}function l(t,e){var a,i;return t?(i=new n,t.state=i,i.window=null,a=o(t,e),a!==A&&(t.state=null),a):C}function h(t){return l(t,mt)}function d(t){if(wt){var e;for(b=new m.Buf32(512),g=new m.Buf32(32),e=0;144>e;)t.lens[e++]=8;for(;256>e;)t.lens[e++]=9;for(;280>e;)t.lens[e++]=7;for(;288>e;)t.lens[e++]=8;for(k(y,t.lens,0,288,b,0,t.work,{bits:9}),e=0;32>e;)t.lens[e++]=5;k(z,t.lens,0,32,g,0,t.work,{bits:5}),wt=!1}t.lencode=b,t.lenbits=9,t.distcode=g,t.distbits=5}function f(t,e,a,i){var n,r=t.state;return null===r.window&&(r.wsize=1<<r.wbits,r.wnext=0,r.whave=0,r.window=new m.Buf8(r.wsize)),i>=r.wsize?(m.arraySet(r.window,e,a-r.wsize,r.wsize,0),r.wnext=0,r.whave=r.wsize):(n=r.wsize-r.wnext,n>i&&(n=i),m.arraySet(r.window,e,a-i,n,r.wnext),i-=n,i?(m.arraySet(r.window,e,a-i,i,0),r.wnext=i,r.whave=r.wsize):(r.wnext+=n,r.wnext===r.wsize&&(r.wnext=0),r.whave<r.wsize&&(r.whave+=n))),0}function _(t,e){var a,n,r,s,o,l,h,_,u,c,b,g,ct,bt,gt,mt,wt,pt,vt,kt,xt,yt,zt,Bt,St=0,Et=new m.Buf8(4),At=[16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15];if(!t||!t.state||!t.output||!t.input&&0!==t.avail_in)return C;a=t.state,a.mode===G&&(a.mode=X),o=t.next_out,r=t.output,h=t.avail_out,s=t.next_in,n=t.input,l=t.avail_in,_=a.hold,u=a.bits,c=l,b=h,yt=A;t:for(;;)switch(a.mode){case D:if(0===a.wrap){a.mode=X;break}for(;16>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(2&a.wrap&&35615===_){a.check=0,Et[0]=255&_,Et[1]=_>>>8&255,a.check=p(a.check,Et,2,0),_=0,u=0,a.mode=U;break}if(a.flags=0,a.head&&(a.head.done=!1),!(1&a.wrap)||(((255&_)<<8)+(_>>8))%31){t.msg="incorrect header check",a.mode=ft;break}if((15&_)!==T){t.msg="unknown compression method",a.mode=ft;break}if(_>>>=4,u-=4,xt=(15&_)+8,0===a.wbits)a.wbits=xt;else if(xt>a.wbits){t.msg="invalid window size",a.mode=ft;break}a.dmax=1<<xt,t.adler=a.check=1,a.mode=512&_?q:G,_=0,u=0;break;case U:for(;16>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(a.flags=_,(255&a.flags)!==T){t.msg="unknown compression method",a.mode=ft;break}if(57344&a.flags){t.msg="unknown header flags set",a.mode=ft;break}a.head&&(a.head.text=_>>8&1),512&a.flags&&(Et[0]=255&_,Et[1]=_>>>8&255,a.check=p(a.check,Et,2,0)),_=0,u=0,a.mode=F;case F:for(;32>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.head&&(a.head.time=_),512&a.flags&&(Et[0]=255&_,Et[1]=_>>>8&255,Et[2]=_>>>16&255,Et[3]=_>>>24&255,a.check=p(a.check,Et,4,0)),_=0,u=0,a.mode=L;case L:for(;16>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.head&&(a.head.xflags=255&_,a.head.os=_>>8),512&a.flags&&(Et[0]=255&_,Et[1]=_>>>8&255,a.check=p(a.check,Et,2,0)),_=0,u=0,a.mode=H;case H:if(1024&a.flags){for(;16>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.length=_,a.head&&(a.head.extra_len=_),512&a.flags&&(Et[0]=255&_,Et[1]=_>>>8&255,a.check=p(a.check,Et,2,0)),_=0,u=0}else a.head&&(a.head.extra=null);a.mode=j;case j:if(1024&a.flags&&(g=a.length,g>l&&(g=l),g&&(a.head&&(xt=a.head.extra_len-a.length,a.head.extra||(a.head.extra=new Array(a.head.extra_len)),m.arraySet(a.head.extra,n,s,g,xt)),512&a.flags&&(a.check=p(a.check,n,g,s)),l-=g,s+=g,a.length-=g),a.length))break t;a.length=0,a.mode=M;case M:if(2048&a.flags){if(0===l)break t;g=0;do xt=n[s+g++],a.head&&xt&&a.length<65536&&(a.head.name+=String.fromCharCode(xt));while(xt&&l>g);if(512&a.flags&&(a.check=p(a.check,n,g,s)),l-=g,s+=g,xt)break t}else a.head&&(a.head.name=null);a.length=0,a.mode=K;case K:if(4096&a.flags){if(0===l)break t;g=0;do xt=n[s+g++],a.head&&xt&&a.length<65536&&(a.head.comment+=String.fromCharCode(xt));while(xt&&l>g);if(512&a.flags&&(a.check=p(a.check,n,g,s)),l-=g,s+=g,xt)break t}else a.head&&(a.head.comment=null);a.mode=P;case P:if(512&a.flags){for(;16>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(_!==(65535&a.check)){t.msg="header crc mismatch",a.mode=ft;break}_=0,u=0}a.head&&(a.head.hcrc=a.flags>>9&1,a.head.done=!0),t.adler=a.check=0,a.mode=G;break;case q:for(;32>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}t.adler=a.check=i(_),_=0,u=0,a.mode=Y;case Y:if(0===a.havedict)return t.next_out=o,t.avail_out=h,t.next_in=s,t.avail_in=l,a.hold=_,a.bits=u,R;t.adler=a.check=1,a.mode=G;case G:if(e===S||e===E)break t;case X:if(a.last){_>>>=7&u,u-=7&u,a.mode=lt;break}for(;3>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}switch(a.last=1&_,_>>>=1,u-=1,3&_){case 0:a.mode=W;break;case 1:if(d(a),a.mode=et,e===E){_>>>=2,u-=2;break t}break;case 2:a.mode=V;break;case 3:t.msg="invalid block type",a.mode=ft}_>>>=2,u-=2;break;case W:for(_>>>=7&u,u-=7&u;32>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if((65535&_)!==(_>>>16^65535)){t.msg="invalid stored block lengths",a.mode=ft;break}if(a.length=65535&_,_=0,u=0,a.mode=J,e===E)break t;case J:a.mode=Q;case Q:if(g=a.length){if(g>l&&(g=l),g>h&&(g=h),0===g)break t;m.arraySet(r,n,s,g,o),l-=g,s+=g,h-=g,o+=g,a.length-=g;break}a.mode=G;break;case V:for(;14>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(a.nlen=(31&_)+257,_>>>=5,u-=5,a.ndist=(31&_)+1,_>>>=5,u-=5,a.ncode=(15&_)+4,_>>>=4,u-=4,a.nlen>286||a.ndist>30){t.msg="too many length or distance symbols",a.mode=ft;break}a.have=0,a.mode=$;case $:for(;a.have<a.ncode;){for(;3>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.lens[At[a.have++]]=7&_,_>>>=3,u-=3}for(;a.have<19;)a.lens[At[a.have++]]=0;if(a.lencode=a.lendyn,a.lenbits=7,zt={bits:a.lenbits},yt=k(x,a.lens,0,19,a.lencode,0,a.work,zt),a.lenbits=zt.bits,yt){t.msg="invalid code lengths set",a.mode=ft;break}a.have=0,a.mode=tt;case tt:for(;a.have<a.nlen+a.ndist;){for(;St=a.lencode[_&(1<<a.lenbits)-1],gt=St>>>24,mt=St>>>16&255,wt=65535&St,!(u>=gt);){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(16>wt)_>>>=gt,u-=gt,a.lens[a.have++]=wt;else{if(16===wt){for(Bt=gt+2;Bt>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(_>>>=gt,u-=gt,0===a.have){t.msg="invalid bit length repeat",a.mode=ft;break}xt=a.lens[a.have-1],g=3+(3&_),_>>>=2,u-=2}else if(17===wt){for(Bt=gt+3;Bt>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}_>>>=gt,u-=gt,xt=0,g=3+(7&_),_>>>=3,u-=3}else{for(Bt=gt+7;Bt>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}_>>>=gt,u-=gt,xt=0,g=11+(127&_),_>>>=7,u-=7}if(a.have+g>a.nlen+a.ndist){t.msg="invalid bit length repeat",a.mode=ft;break}for(;g--;)a.lens[a.have++]=xt}}if(a.mode===ft)break;if(0===a.lens[256]){t.msg="invalid code -- missing end-of-block",a.mode=ft;break}if(a.lenbits=9,zt={bits:a.lenbits},yt=k(y,a.lens,0,a.nlen,a.lencode,0,a.work,zt),a.lenbits=zt.bits,yt){t.msg="invalid literal/lengths set",a.mode=ft;break}if(a.distbits=6,a.distcode=a.distdyn,zt={bits:a.distbits},yt=k(z,a.lens,a.nlen,a.ndist,a.distcode,0,a.work,zt),
a.distbits=zt.bits,yt){t.msg="invalid distances set",a.mode=ft;break}if(a.mode=et,e===E)break t;case et:a.mode=at;case at:if(l>=6&&h>=258){t.next_out=o,t.avail_out=h,t.next_in=s,t.avail_in=l,a.hold=_,a.bits=u,v(t,b),o=t.next_out,r=t.output,h=t.avail_out,s=t.next_in,n=t.input,l=t.avail_in,_=a.hold,u=a.bits,a.mode===G&&(a.back=-1);break}for(a.back=0;St=a.lencode[_&(1<<a.lenbits)-1],gt=St>>>24,mt=St>>>16&255,wt=65535&St,!(u>=gt);){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(mt&&0===(240&mt)){for(pt=gt,vt=mt,kt=wt;St=a.lencode[kt+((_&(1<<pt+vt)-1)>>pt)],gt=St>>>24,mt=St>>>16&255,wt=65535&St,!(u>=pt+gt);){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}_>>>=pt,u-=pt,a.back+=pt}if(_>>>=gt,u-=gt,a.back+=gt,a.length=wt,0===mt){a.mode=ot;break}if(32&mt){a.back=-1,a.mode=G;break}if(64&mt){t.msg="invalid literal/length code",a.mode=ft;break}a.extra=15&mt,a.mode=it;case it:if(a.extra){for(Bt=a.extra;Bt>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.length+=_&(1<<a.extra)-1,_>>>=a.extra,u-=a.extra,a.back+=a.extra}a.was=a.length,a.mode=nt;case nt:for(;St=a.distcode[_&(1<<a.distbits)-1],gt=St>>>24,mt=St>>>16&255,wt=65535&St,!(u>=gt);){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(0===(240&mt)){for(pt=gt,vt=mt,kt=wt;St=a.distcode[kt+((_&(1<<pt+vt)-1)>>pt)],gt=St>>>24,mt=St>>>16&255,wt=65535&St,!(u>=pt+gt);){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}_>>>=pt,u-=pt,a.back+=pt}if(_>>>=gt,u-=gt,a.back+=gt,64&mt){t.msg="invalid distance code",a.mode=ft;break}a.offset=wt,a.extra=15&mt,a.mode=rt;case rt:if(a.extra){for(Bt=a.extra;Bt>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}a.offset+=_&(1<<a.extra)-1,_>>>=a.extra,u-=a.extra,a.back+=a.extra}if(a.offset>a.dmax){t.msg="invalid distance too far back",a.mode=ft;break}a.mode=st;case st:if(0===h)break t;if(g=b-h,a.offset>g){if(g=a.offset-g,g>a.whave&&a.sane){t.msg="invalid distance too far back",a.mode=ft;break}g>a.wnext?(g-=a.wnext,ct=a.wsize-g):ct=a.wnext-g,g>a.length&&(g=a.length),bt=a.window}else bt=r,ct=o-a.offset,g=a.length;g>h&&(g=h),h-=g,a.length-=g;do r[o++]=bt[ct++];while(--g);0===a.length&&(a.mode=at);break;case ot:if(0===h)break t;r[o++]=a.length,h--,a.mode=at;break;case lt:if(a.wrap){for(;32>u;){if(0===l)break t;l--,_|=n[s++]<<u,u+=8}if(b-=h,t.total_out+=b,a.total+=b,b&&(t.adler=a.check=a.flags?p(a.check,r,b,o-b):w(a.check,r,b,o-b)),b=h,(a.flags?_:i(_))!==a.check){t.msg="incorrect data check",a.mode=ft;break}_=0,u=0}a.mode=ht;case ht:if(a.wrap&&a.flags){for(;32>u;){if(0===l)break t;l--,_+=n[s++]<<u,u+=8}if(_!==(4294967295&a.total)){t.msg="incorrect length check",a.mode=ft;break}_=0,u=0}a.mode=dt;case dt:yt=Z;break t;case ft:yt=N;break t;case _t:return I;case ut:default:return C}return t.next_out=o,t.avail_out=h,t.next_in=s,t.avail_in=l,a.hold=_,a.bits=u,(a.wsize||b!==t.avail_out&&a.mode<ft&&(a.mode<lt||e!==B))&&f(t,t.output,t.next_out,b-t.avail_out)?(a.mode=_t,I):(c-=t.avail_in,b-=t.avail_out,t.total_in+=c,t.total_out+=b,a.total+=b,a.wrap&&b&&(t.adler=a.check=a.flags?p(a.check,r,b,t.next_out-b):w(a.check,r,b,t.next_out-b)),t.data_type=a.bits+(a.last?64:0)+(a.mode===G?128:0)+(a.mode===et||a.mode===J?256:0),(0===c&&0===b||e===B)&&yt===A&&(yt=O),yt)}function u(t){if(!t||!t.state)return C;var e=t.state;return e.window&&(e.window=null),t.state=null,A}function c(t,e){var a;return t&&t.state?(a=t.state,0===(2&a.wrap)?C:(a.head=e,e.done=!1,A)):C}var b,g,m=t("../utils/common"),w=t("./adler32"),p=t("./crc32"),v=t("./inffast"),k=t("./inftrees"),x=0,y=1,z=2,B=4,S=5,E=6,A=0,Z=1,R=2,C=-2,N=-3,I=-4,O=-5,T=8,D=1,U=2,F=3,L=4,H=5,j=6,M=7,K=8,P=9,q=10,Y=11,G=12,X=13,W=14,J=15,Q=16,V=17,$=18,tt=19,et=20,at=21,it=22,nt=23,rt=24,st=25,ot=26,lt=27,ht=28,dt=29,ft=30,_t=31,ut=32,ct=852,bt=592,gt=15,mt=gt,wt=!0;a.inflateReset=s,a.inflateReset2=o,a.inflateResetKeep=r,a.inflateInit=h,a.inflateInit2=l,a.inflate=_,a.inflateEnd=u,a.inflateGetHeader=c,a.inflateInfo="pako inflate (from Nodeca project)"},{"../utils/common":3,"./adler32":5,"./crc32":7,"./inffast":10,"./inftrees":12}],12:[function(t,e){"use strict";var a=t("../utils/common"),i=15,n=852,r=592,s=0,o=1,l=2,h=[3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258,0,0],d=[16,16,16,16,16,16,16,16,17,17,17,17,18,18,18,18,19,19,19,19,20,20,20,20,21,21,21,21,16,72,78],f=[1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577,0,0],_=[16,16,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23,24,24,25,25,26,26,27,27,28,28,29,29,64,64];e.exports=function(t,e,u,c,b,g,m,w){var p,v,k,x,y,z,B,S,E,A=w.bits,Z=0,R=0,C=0,N=0,I=0,O=0,T=0,D=0,U=0,F=0,L=null,H=0,j=new a.Buf16(i+1),M=new a.Buf16(i+1),K=null,P=0;for(Z=0;i>=Z;Z++)j[Z]=0;for(R=0;c>R;R++)j[e[u+R]]++;for(I=A,N=i;N>=1&&0===j[N];N--);if(I>N&&(I=N),0===N)return b[g++]=20971520,b[g++]=20971520,w.bits=1,0;for(C=1;N>C&&0===j[C];C++);for(C>I&&(I=C),D=1,Z=1;i>=Z;Z++)if(D<<=1,D-=j[Z],0>D)return-1;if(D>0&&(t===s||1!==N))return-1;for(M[1]=0,Z=1;i>Z;Z++)M[Z+1]=M[Z]+j[Z];for(R=0;c>R;R++)0!==e[u+R]&&(m[M[e[u+R]]++]=R);if(t===s?(L=K=m,z=19):t===o?(L=h,H-=257,K=d,P-=257,z=256):(L=f,K=_,z=-1),F=0,R=0,Z=C,y=g,O=I,T=0,k=-1,U=1<<I,x=U-1,t===o&&U>n||t===l&&U>r)return 1;for(var q=0;;){q++,B=Z-T,m[R]<z?(S=0,E=m[R]):m[R]>z?(S=K[P+m[R]],E=L[H+m[R]]):(S=96,E=0),p=1<<Z-T,v=1<<O,C=v;do v-=p,b[y+(F>>T)+v]=B<<24|S<<16|E|0;while(0!==v);for(p=1<<Z-1;F&p;)p>>=1;if(0!==p?(F&=p-1,F+=p):F=0,R++,0===--j[Z]){if(Z===N)break;Z=e[u+m[R]]}if(Z>I&&(F&x)!==k){for(0===T&&(T=I),y+=C,O=Z-T,D=1<<O;N>O+T&&(D-=j[O+T],!(0>=D));)O++,D<<=1;if(U+=1<<O,t===o&&U>n||t===l&&U>r)return 1;k=F&x,b[k]=I<<24|O<<16|y-g|0}}return 0!==F&&(b[y+F]=Z-T<<24|64<<16|0),w.bits=I,0}},{"../utils/common":3}],13:[function(t,e){"use strict";e.exports={2:"need dictionary",1:"stream end",0:"","-1":"file error","-2":"stream error","-3":"data error","-4":"insufficient memory","-5":"buffer error","-6":"incompatible version"}},{}],14:[function(t,e,a){"use strict";function i(t){for(var e=t.length;--e>=0;)t[e]=0}function n(t){return 256>t?st[t]:st[256+(t>>>7)]}function r(t,e){t.pending_buf[t.pending++]=255&e,t.pending_buf[t.pending++]=e>>>8&255}function s(t,e,a){t.bi_valid>G-a?(t.bi_buf|=e<<t.bi_valid&65535,r(t,t.bi_buf),t.bi_buf=e>>G-t.bi_valid,t.bi_valid+=a-G):(t.bi_buf|=e<<t.bi_valid&65535,t.bi_valid+=a)}function o(t,e,a){s(t,a[2*e],a[2*e+1])}function l(t,e){var a=0;do a|=1&t,t>>>=1,a<<=1;while(--e>0);return a>>>1}function h(t){16===t.bi_valid?(r(t,t.bi_buf),t.bi_buf=0,t.bi_valid=0):t.bi_valid>=8&&(t.pending_buf[t.pending++]=255&t.bi_buf,t.bi_buf>>=8,t.bi_valid-=8)}function d(t,e){var a,i,n,r,s,o,l=e.dyn_tree,h=e.max_code,d=e.stat_desc.static_tree,f=e.stat_desc.has_stree,_=e.stat_desc.extra_bits,u=e.stat_desc.extra_base,c=e.stat_desc.max_length,b=0;for(r=0;Y>=r;r++)t.bl_count[r]=0;for(l[2*t.heap[t.heap_max]+1]=0,a=t.heap_max+1;q>a;a++)i=t.heap[a],r=l[2*l[2*i+1]+1]+1,r>c&&(r=c,b++),l[2*i+1]=r,i>h||(t.bl_count[r]++,s=0,i>=u&&(s=_[i-u]),o=l[2*i],t.opt_len+=o*(r+s),f&&(t.static_len+=o*(d[2*i+1]+s)));if(0!==b){do{for(r=c-1;0===t.bl_count[r];)r--;t.bl_count[r]--,t.bl_count[r+1]+=2,t.bl_count[c]--,b-=2}while(b>0);for(r=c;0!==r;r--)for(i=t.bl_count[r];0!==i;)n=t.heap[--a],n>h||(l[2*n+1]!==r&&(t.opt_len+=(r-l[2*n+1])*l[2*n],l[2*n+1]=r),i--)}}function f(t,e,a){var i,n,r=new Array(Y+1),s=0;for(i=1;Y>=i;i++)r[i]=s=s+a[i-1]<<1;for(n=0;e>=n;n++){var o=t[2*n+1];0!==o&&(t[2*n]=l(r[o]++,o))}}function _(){var t,e,a,i,n,r=new Array(Y+1);for(a=0,i=0;H-1>i;i++)for(lt[i]=a,t=0;t<1<<$[i];t++)ot[a++]=i;for(ot[a-1]=i,n=0,i=0;16>i;i++)for(ht[i]=n,t=0;t<1<<tt[i];t++)st[n++]=i;for(n>>=7;K>i;i++)for(ht[i]=n<<7,t=0;t<1<<tt[i]-7;t++)st[256+n++]=i;for(e=0;Y>=e;e++)r[e]=0;for(t=0;143>=t;)nt[2*t+1]=8,t++,r[8]++;for(;255>=t;)nt[2*t+1]=9,t++,r[9]++;for(;279>=t;)nt[2*t+1]=7,t++,r[7]++;for(;287>=t;)nt[2*t+1]=8,t++,r[8]++;for(f(nt,M+1,r),t=0;K>t;t++)rt[2*t+1]=5,rt[2*t]=l(t,5);dt=new ut(nt,$,j+1,M,Y),ft=new ut(rt,tt,0,K,Y),_t=new ut(new Array(0),et,0,P,X)}function u(t){var e;for(e=0;M>e;e++)t.dyn_ltree[2*e]=0;for(e=0;K>e;e++)t.dyn_dtree[2*e]=0;for(e=0;P>e;e++)t.bl_tree[2*e]=0;t.dyn_ltree[2*W]=1,t.opt_len=t.static_len=0,t.last_lit=t.matches=0}function c(t){t.bi_valid>8?r(t,t.bi_buf):t.bi_valid>0&&(t.pending_buf[t.pending++]=t.bi_buf),t.bi_buf=0,t.bi_valid=0}function b(t,e,a,i){c(t),i&&(r(t,a),r(t,~a)),R.arraySet(t.pending_buf,t.window,e,a,t.pending),t.pending+=a}function g(t,e,a,i){var n=2*e,r=2*a;return t[n]<t[r]||t[n]===t[r]&&i[e]<=i[a]}function m(t,e,a){for(var i=t.heap[a],n=a<<1;n<=t.heap_len&&(n<t.heap_len&&g(e,t.heap[n+1],t.heap[n],t.depth)&&n++,!g(e,i,t.heap[n],t.depth));)t.heap[a]=t.heap[n],a=n,n<<=1;t.heap[a]=i}function w(t,e,a){var i,r,l,h,d=0;if(0!==t.last_lit)do i=t.pending_buf[t.d_buf+2*d]<<8|t.pending_buf[t.d_buf+2*d+1],r=t.pending_buf[t.l_buf+d],d++,0===i?o(t,r,e):(l=ot[r],o(t,l+j+1,e),h=$[l],0!==h&&(r-=lt[l],s(t,r,h)),i--,l=n(i),o(t,l,a),h=tt[l],0!==h&&(i-=ht[l],s(t,i,h)));while(d<t.last_lit);o(t,W,e)}function p(t,e){var a,i,n,r=e.dyn_tree,s=e.stat_desc.static_tree,o=e.stat_desc.has_stree,l=e.stat_desc.elems,h=-1;for(t.heap_len=0,t.heap_max=q,a=0;l>a;a++)0!==r[2*a]?(t.heap[++t.heap_len]=h=a,t.depth[a]=0):r[2*a+1]=0;for(;t.heap_len<2;)n=t.heap[++t.heap_len]=2>h?++h:0,r[2*n]=1,t.depth[n]=0,t.opt_len--,o&&(t.static_len-=s[2*n+1]);for(e.max_code=h,a=t.heap_len>>1;a>=1;a--)m(t,r,a);n=l;do a=t.heap[1],t.heap[1]=t.heap[t.heap_len--],m(t,r,1),i=t.heap[1],t.heap[--t.heap_max]=a,t.heap[--t.heap_max]=i,r[2*n]=r[2*a]+r[2*i],t.depth[n]=(t.depth[a]>=t.depth[i]?t.depth[a]:t.depth[i])+1,r[2*a+1]=r[2*i+1]=n,t.heap[1]=n++,m(t,r,1);while(t.heap_len>=2);t.heap[--t.heap_max]=t.heap[1],d(t,e),f(r,h,t.bl_count)}function v(t,e,a){var i,n,r=-1,s=e[1],o=0,l=7,h=4;for(0===s&&(l=138,h=3),e[2*(a+1)+1]=65535,i=0;a>=i;i++)n=s,s=e[2*(i+1)+1],++o<l&&n===s||(h>o?t.bl_tree[2*n]+=o:0!==n?(n!==r&&t.bl_tree[2*n]++,t.bl_tree[2*J]++):10>=o?t.bl_tree[2*Q]++:t.bl_tree[2*V]++,o=0,r=n,0===s?(l=138,h=3):n===s?(l=6,h=3):(l=7,h=4))}function k(t,e,a){var i,n,r=-1,l=e[1],h=0,d=7,f=4;for(0===l&&(d=138,f=3),i=0;a>=i;i++)if(n=l,l=e[2*(i+1)+1],!(++h<d&&n===l)){if(f>h){do o(t,n,t.bl_tree);while(0!==--h)}else 0!==n?(n!==r&&(o(t,n,t.bl_tree),h--),o(t,J,t.bl_tree),s(t,h-3,2)):10>=h?(o(t,Q,t.bl_tree),s(t,h-3,3)):(o(t,V,t.bl_tree),s(t,h-11,7));h=0,r=n,0===l?(d=138,f=3):n===l?(d=6,f=3):(d=7,f=4)}}function x(t){var e;for(v(t,t.dyn_ltree,t.l_desc.max_code),v(t,t.dyn_dtree,t.d_desc.max_code),p(t,t.bl_desc),e=P-1;e>=3&&0===t.bl_tree[2*at[e]+1];e--);return t.opt_len+=3*(e+1)+5+5+4,e}function y(t,e,a,i){var n;for(s(t,e-257,5),s(t,a-1,5),s(t,i-4,4),n=0;i>n;n++)s(t,t.bl_tree[2*at[n]+1],3);k(t,t.dyn_ltree,e-1),k(t,t.dyn_dtree,a-1)}function z(t){var e,a=4093624447;for(e=0;31>=e;e++,a>>>=1)if(1&a&&0!==t.dyn_ltree[2*e])return N;if(0!==t.dyn_ltree[18]||0!==t.dyn_ltree[20]||0!==t.dyn_ltree[26])return I;for(e=32;j>e;e++)if(0!==t.dyn_ltree[2*e])return I;return N}function B(t){bt||(_(),bt=!0),t.l_desc=new ct(t.dyn_ltree,dt),t.d_desc=new ct(t.dyn_dtree,ft),t.bl_desc=new ct(t.bl_tree,_t),t.bi_buf=0,t.bi_valid=0,u(t)}function S(t,e,a,i){s(t,(T<<1)+(i?1:0),3),b(t,e,a,!0)}function E(t){s(t,D<<1,3),o(t,W,nt),h(t)}function A(t,e,a,i){var n,r,o=0;t.level>0?(t.strm.data_type===O&&(t.strm.data_type=z(t)),p(t,t.l_desc),p(t,t.d_desc),o=x(t),n=t.opt_len+3+7>>>3,r=t.static_len+3+7>>>3,n>=r&&(n=r)):n=r=a+5,n>=a+4&&-1!==e?S(t,e,a,i):t.strategy===C||r===n?(s(t,(D<<1)+(i?1:0),3),w(t,nt,rt)):(s(t,(U<<1)+(i?1:0),3),y(t,t.l_desc.max_code+1,t.d_desc.max_code+1,o+1),w(t,t.dyn_ltree,t.dyn_dtree)),u(t),i&&c(t)}function Z(t,e,a){return t.pending_buf[t.d_buf+2*t.last_lit]=e>>>8&255,t.pending_buf[t.d_buf+2*t.last_lit+1]=255&e,t.pending_buf[t.l_buf+t.last_lit]=255&a,t.last_lit++,0===e?t.dyn_ltree[2*a]++:(t.matches++,e--,t.dyn_ltree[2*(ot[a]+j+1)]++,t.dyn_dtree[2*n(e)]++),t.last_lit===t.lit_bufsize-1}var R=t("../utils/common"),C=4,N=0,I=1,O=2,T=0,D=1,U=2,F=3,L=258,H=29,j=256,M=j+1+H,K=30,P=19,q=2*M+1,Y=15,G=16,X=7,W=256,J=16,Q=17,V=18,$=[0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0],tt=[0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13],et=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7],at=[16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15],it=512,nt=new Array(2*(M+2));i(nt);var rt=new Array(2*K);i(rt);var st=new Array(it);i(st);var ot=new Array(L-F+1);i(ot);var lt=new Array(H);i(lt);var ht=new Array(K);i(ht);var dt,ft,_t,ut=function(t,e,a,i,n){this.static_tree=t,this.extra_bits=e,this.extra_base=a,this.elems=i,this.max_length=n,this.has_stree=t&&t.length},ct=function(t,e){this.dyn_tree=t,this.max_code=0,this.stat_desc=e},bt=!1;a._tr_init=B,a._tr_stored_block=S,a._tr_flush_block=A,a._tr_tally=Z,a._tr_align=E},{"../utils/common":3}],15:[function(t,e){"use strict";function a(){this.input=null,this.next_in=0,this.avail_in=0,this.total_in=0,this.output=null,this.next_out=0,this.avail_out=0,this.total_out=0,this.msg="",this.state=null,this.data_type=2,this.adler=0}e.exports=a},{}],"/":[function(t,e){"use strict";var a=t("./lib/utils/common").assign,i=t("./lib/deflate"),n=t("./lib/inflate"),r=t("./lib/zlib/constants"),s={};a(s,i,n,r),e.exports=s},{"./lib/deflate":1,"./lib/inflate":2,"./lib/utils/common":3,"./lib/zlib/constants":6}]},{},[])("/")});

if (window.moment == null){
//ACTIVE VERSION 2.20.1 OF MOMENT.JS UPDATED WITH MINIFIED VERSION 
//! moment.js
//! version : 2.20.1
//! authors : Tim Wood, Iskren Chernev, Moment.js contributors
//! license : MIT
//! momentjs.com
!function(e,t){"object"==typeof exports&&"undefined"!=typeof module?module.exports=t():"function"==typeof define&&define.amd?define(t):e.moment=t()}(this,function(){"use strict";function e(){return Qe.apply(null,arguments)}function t(e){return e instanceof Array||"[object Array]"===Object.prototype.toString.call(e)}function n(e){return null!=e&&"[object Object]"===Object.prototype.toString.call(e)}function s(e){return void 0===e}function i(e){return"number"==typeof e||"[object Number]"===Object.prototype.toString.call(e)}function r(e){return e instanceof Date||"[object Date]"===Object.prototype.toString.call(e)}function a(e,t){var n,s=[];for(n=0;n<e.length;++n)s.push(t(e[n],n));return s}function o(e,t){return Object.prototype.hasOwnProperty.call(e,t)}function u(e,t){for(var n in t)o(t,n)&&(e[n]=t[n]);return o(t,"toString")&&(e.toString=t.toString),o(t,"valueOf")&&(e.valueOf=t.valueOf),e}function l(e,t,n,s){return ge(e,t,n,s,!0).utc()}function d(e){return null==e._pf&&(e._pf={empty:!1,unusedTokens:[],unusedInput:[],overflow:-2,charsLeftOver:0,nullInput:!1,invalidMonth:null,invalidFormat:!1,userInvalidated:!1,iso:!1,parsedDateParts:[],meridiem:null,rfc2822:!1,weekdayMismatch:!1}),e._pf}function h(e){if(null==e._isValid){var t=d(e),n=Xe.call(t.parsedDateParts,function(e){return null!=e}),s=!isNaN(e._d.getTime())&&t.overflow<0&&!t.empty&&!t.invalidMonth&&!t.invalidWeekday&&!t.weekdayMismatch&&!t.nullInput&&!t.invalidFormat&&!t.userInvalidated&&(!t.meridiem||t.meridiem&&n);if(e._strict&&(s=s&&0===t.charsLeftOver&&0===t.unusedTokens.length&&void 0===t.bigHour),null!=Object.isFrozen&&Object.isFrozen(e))return s;e._isValid=s}return e._isValid}function c(e){var t=l(NaN);return null!=e?u(d(t),e):d(t).userInvalidated=!0,t}function f(e,t){var n,i,r;if(s(t._isAMomentObject)||(e._isAMomentObject=t._isAMomentObject),s(t._i)||(e._i=t._i),s(t._f)||(e._f=t._f),s(t._l)||(e._l=t._l),s(t._strict)||(e._strict=t._strict),s(t._tzm)||(e._tzm=t._tzm),s(t._isUTC)||(e._isUTC=t._isUTC),s(t._offset)||(e._offset=t._offset),s(t._pf)||(e._pf=d(t)),s(t._locale)||(e._locale=t._locale),Ke.length>0)for(n=0;n<Ke.length;n++)s(r=t[i=Ke[n]])||(e[i]=r);return e}function m(t){f(this,t),this._d=new Date(null!=t._d?t._d.getTime():NaN),this.isValid()||(this._d=new Date(NaN)),!1===et&&(et=!0,e.updateOffset(this),et=!1)}function _(e){return e instanceof m||null!=e&&null!=e._isAMomentObject}function y(e){return e<0?Math.ceil(e)||0:Math.floor(e)}function g(e){var t=+e,n=0;return 0!==t&&isFinite(t)&&(n=y(t)),n}function p(e,t,n){var s,i=Math.min(e.length,t.length),r=Math.abs(e.length-t.length),a=0;for(s=0;s<i;s++)(n&&e[s]!==t[s]||!n&&g(e[s])!==g(t[s]))&&a++;return a+r}function w(t){!1===e.suppressDeprecationWarnings&&"undefined"!=typeof console&&console.warn&&console.warn("Deprecation warning: "+t)}function v(t,n){var s=!0;return u(function(){if(null!=e.deprecationHandler&&e.deprecationHandler(null,t),s){for(var i,r=[],a=0;a<arguments.length;a++){if(i="","object"==typeof arguments[a]){i+="\n["+a+"] ";for(var o in arguments[0])i+=o+": "+arguments[0][o]+", ";i=i.slice(0,-2)}else i=arguments[a];r.push(i)}w(t+"\nArguments: "+Array.prototype.slice.call(r).join("")+"\n"+(new Error).stack),s=!1}return n.apply(this,arguments)},n)}function M(t,n){null!=e.deprecationHandler&&e.deprecationHandler(t,n),tt[t]||(w(n),tt[t]=!0)}function S(e){return e instanceof Function||"[object Function]"===Object.prototype.toString.call(e)}function D(e,t){var s,i=u({},e);for(s in t)o(t,s)&&(n(e[s])&&n(t[s])?(i[s]={},u(i[s],e[s]),u(i[s],t[s])):null!=t[s]?i[s]=t[s]:delete i[s]);for(s in e)o(e,s)&&!o(t,s)&&n(e[s])&&(i[s]=u({},i[s]));return i}function k(e){null!=e&&this.set(e)}function Y(e,t){var n=e.toLowerCase();st[n]=st[n+"s"]=st[t]=e}function O(e){return"string"==typeof e?st[e]||st[e.toLowerCase()]:void 0}function T(e){var t,n,s={};for(n in e)o(e,n)&&(t=O(n))&&(s[t]=e[n]);return s}function x(e,t){it[e]=t}function b(e,t,n){var s=""+Math.abs(e),i=t-s.length;return(e>=0?n?"+":"":"-")+Math.pow(10,Math.max(0,i)).toString().substr(1)+s}function P(e,t,n,s){var i=s;"string"==typeof s&&(i=function(){return this[s]()}),e&&(ut[e]=i),t&&(ut[t[0]]=function(){return b(i.apply(this,arguments),t[1],t[2])}),n&&(ut[n]=function(){return this.localeData().ordinal(i.apply(this,arguments),e)})}function W(e){return e.match(/\[[\s\S]/)?e.replace(/^\[|\]$/g,""):e.replace(/\\/g,"")}function H(e,t){return e.isValid()?(t=R(t,e.localeData()),ot[t]=ot[t]||function(e){var t,n,s=e.match(rt);for(t=0,n=s.length;t<n;t++)ut[s[t]]?s[t]=ut[s[t]]:s[t]=W(s[t]);return function(t){var i,r="";for(i=0;i<n;i++)r+=S(s[i])?s[i].call(t,e):s[i];return r}}(t),ot[t](e)):e.localeData().invalidDate()}function R(e,t){function n(e){return t.longDateFormat(e)||e}var s=5;for(at.lastIndex=0;s>=0&&at.test(e);)e=e.replace(at,n),at.lastIndex=0,s-=1;return e}function C(e,t,n){Yt[e]=S(t)?t:function(e,s){return e&&n?n:t}}function F(e,t){return o(Yt,e)?Yt[e](t._strict,t._locale):new RegExp(function(e){return U(e.replace("\\","").replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g,function(e,t,n,s,i){return t||n||s||i}))}(e))}function U(e){return e.replace(/[-\/\\^$*+?.()|[\]{}]/g,"\\$&")}function L(e,t){var n,s=t;for("string"==typeof e&&(e=[e]),i(t)&&(s=function(e,n){n[t]=g(e)}),n=0;n<e.length;n++)Ot[e[n]]=s}function N(e,t){L(e,function(e,n,s,i){s._w=s._w||{},t(e,s._w,s,i)})}function G(e,t,n){null!=t&&o(Ot,e)&&Ot[e](t,n._a,n,e)}function V(e){return E(e)?366:365}function E(e){return e%4==0&&e%100!=0||e%400==0}function I(t,n){return function(s){return null!=s?(j(this,t,s),e.updateOffset(this,n),this):A(this,t)}}function A(e,t){return e.isValid()?e._d["get"+(e._isUTC?"UTC":"")+t]():NaN}function j(e,t,n){e.isValid()&&!isNaN(n)&&("FullYear"===t&&E(e.year())&&1===e.month()&&29===e.date()?e._d["set"+(e._isUTC?"UTC":"")+t](n,e.month(),Z(n,e.month())):e._d["set"+(e._isUTC?"UTC":"")+t](n))}function Z(e,t){if(isNaN(e)||isNaN(t))return NaN;var n=function(e,t){return(e%t+t)%t}(t,12);return e+=(t-n)/12,1===n?E(e)?29:28:31-n%7%2}function z(e,t){var n;if(!e.isValid())return e;if("string"==typeof t)if(/^\d+$/.test(t))t=g(t);else if(t=e.localeData().monthsParse(t),!i(t))return e;return n=Math.min(e.date(),Z(e.year(),t)),e._d["set"+(e._isUTC?"UTC":"")+"Month"](t,n),e}function $(t){return null!=t?(z(this,t),e.updateOffset(this,!0),this):A(this,"Month")}function q(){function e(e,t){return t.length-e.length}var t,n,s=[],i=[],r=[];for(t=0;t<12;t++)n=l([2e3,t]),s.push(this.monthsShort(n,"")),i.push(this.months(n,"")),r.push(this.months(n,"")),r.push(this.monthsShort(n,""));for(s.sort(e),i.sort(e),r.sort(e),t=0;t<12;t++)s[t]=U(s[t]),i[t]=U(i[t]);for(t=0;t<24;t++)r[t]=U(r[t]);this._monthsRegex=new RegExp("^("+r.join("|")+")","i"),this._monthsShortRegex=this._monthsRegex,this._monthsStrictRegex=new RegExp("^("+i.join("|")+")","i"),this._monthsShortStrictRegex=new RegExp("^("+s.join("|")+")","i")}function J(e){var t=new Date(Date.UTC.apply(null,arguments));return e<100&&e>=0&&isFinite(t.getUTCFullYear())&&t.setUTCFullYear(e),t}function B(e,t,n){var s=7+t-n;return-((7+J(e,0,s).getUTCDay()-t)%7)+s-1}function Q(e,t,n,s,i){var r,a,o=1+7*(t-1)+(7+n-s)%7+B(e,s,i);return o<=0?a=V(r=e-1)+o:o>V(e)?(r=e+1,a=o-V(e)):(r=e,a=o),{year:r,dayOfYear:a}}function X(e,t,n){var s,i,r=B(e.year(),t,n),a=Math.floor((e.dayOfYear()-r-1)/7)+1;return a<1?s=a+K(i=e.year()-1,t,n):a>K(e.year(),t,n)?(s=a-K(e.year(),t,n),i=e.year()+1):(i=e.year(),s=a),{week:s,year:i}}function K(e,t,n){var s=B(e,t,n),i=B(e+1,t,n);return(V(e)-s+i)/7}function ee(){function e(e,t){return t.length-e.length}var t,n,s,i,r,a=[],o=[],u=[],d=[];for(t=0;t<7;t++)n=l([2e3,1]).day(t),s=this.weekdaysMin(n,""),i=this.weekdaysShort(n,""),r=this.weekdays(n,""),a.push(s),o.push(i),u.push(r),d.push(s),d.push(i),d.push(r);for(a.sort(e),o.sort(e),u.sort(e),d.sort(e),t=0;t<7;t++)o[t]=U(o[t]),u[t]=U(u[t]),d[t]=U(d[t]);this._weekdaysRegex=new RegExp("^("+d.join("|")+")","i"),this._weekdaysShortRegex=this._weekdaysRegex,this._weekdaysMinRegex=this._weekdaysRegex,this._weekdaysStrictRegex=new RegExp("^("+u.join("|")+")","i"),this._weekdaysShortStrictRegex=new RegExp("^("+o.join("|")+")","i"),this._weekdaysMinStrictRegex=new RegExp("^("+a.join("|")+")","i")}function te(){return this.hours()%12||12}function ne(e,t){P(e,0,0,function(){return this.localeData().meridiem(this.hours(),this.minutes(),t)})}function se(e,t){return t._meridiemParse}function ie(e){return e?e.toLowerCase().replace("_","-"):e}function re(e){var t=null;if(!Xt[e]&&"undefined"!=typeof module&&module&&module.exports)try{t=Jt._abbr;require("./locale/"+e),ae(t)}catch(e){}return Xt[e]}function ae(e,t){var n;return e&&(n=s(t)?ue(e):oe(e,t))&&(Jt=n),Jt._abbr}function oe(e,t){if(null!==t){var n=Qt;if(t.abbr=e,null!=Xt[e])M("defineLocaleOverride","use moment.updateLocale(localeName, config) to change an existing locale. moment.defineLocale(localeName, config) should only be used for creating a new locale See http://momentjs.com/guides/#/warnings/define-locale/ for more info."),n=Xt[e]._config;else if(null!=t.parentLocale){if(null==Xt[t.parentLocale])return Kt[t.parentLocale]||(Kt[t.parentLocale]=[]),Kt[t.parentLocale].push({name:e,config:t}),null;n=Xt[t.parentLocale]._config}return Xt[e]=new k(D(n,t)),Kt[e]&&Kt[e].forEach(function(e){oe(e.name,e.config)}),ae(e),Xt[e]}return delete Xt[e],null}function ue(e){var n;if(e&&e._locale&&e._locale._abbr&&(e=e._locale._abbr),!e)return Jt;if(!t(e)){if(n=re(e))return n;e=[e]}return function(e){for(var t,n,s,i,r=0;r<e.length;){for(t=(i=ie(e[r]).split("-")).length,n=(n=ie(e[r+1]))?n.split("-"):null;t>0;){if(s=re(i.slice(0,t).join("-")))return s;if(n&&n.length>=t&&p(i,n,!0)>=t-1)break;t--}r++}return null}(e)}function le(e){var t,n=e._a;return n&&-2===d(e).overflow&&(t=n[xt]<0||n[xt]>11?xt:n[bt]<1||n[bt]>Z(n[Tt],n[xt])?bt:n[Pt]<0||n[Pt]>24||24===n[Pt]&&(0!==n[Wt]||0!==n[Ht]||0!==n[Rt])?Pt:n[Wt]<0||n[Wt]>59?Wt:n[Ht]<0||n[Ht]>59?Ht:n[Rt]<0||n[Rt]>999?Rt:-1,d(e)._overflowDayOfYear&&(t<Tt||t>bt)&&(t=bt),d(e)._overflowWeeks&&-1===t&&(t=Ct),d(e)._overflowWeekday&&-1===t&&(t=Ft),d(e).overflow=t),e}function de(e,t,n){return null!=e?e:null!=t?t:n}function he(t){var n,s,i,r,a,o=[];if(!t._d){for(i=function(t){var n=new Date(e.now());return t._useUTC?[n.getUTCFullYear(),n.getUTCMonth(),n.getUTCDate()]:[n.getFullYear(),n.getMonth(),n.getDate()]}(t),t._w&&null==t._a[bt]&&null==t._a[xt]&&function(e){var t,n,s,i,r,a,o,u;if(null!=(t=e._w).GG||null!=t.W||null!=t.E)r=1,a=4,n=de(t.GG,e._a[Tt],X(pe(),1,4).year),s=de(t.W,1),((i=de(t.E,1))<1||i>7)&&(u=!0);else{r=e._locale._week.dow,a=e._locale._week.doy;var l=X(pe(),r,a);n=de(t.gg,e._a[Tt],l.year),s=de(t.w,l.week),null!=t.d?((i=t.d)<0||i>6)&&(u=!0):null!=t.e?(i=t.e+r,(t.e<0||t.e>6)&&(u=!0)):i=r}s<1||s>K(n,r,a)?d(e)._overflowWeeks=!0:null!=u?d(e)._overflowWeekday=!0:(o=Q(n,s,i,r,a),e._a[Tt]=o.year,e._dayOfYear=o.dayOfYear)}(t),null!=t._dayOfYear&&(a=de(t._a[Tt],i[Tt]),(t._dayOfYear>V(a)||0===t._dayOfYear)&&(d(t)._overflowDayOfYear=!0),s=J(a,0,t._dayOfYear),t._a[xt]=s.getUTCMonth(),t._a[bt]=s.getUTCDate()),n=0;n<3&&null==t._a[n];++n)t._a[n]=o[n]=i[n];for(;n<7;n++)t._a[n]=o[n]=null==t._a[n]?2===n?1:0:t._a[n];24===t._a[Pt]&&0===t._a[Wt]&&0===t._a[Ht]&&0===t._a[Rt]&&(t._nextDay=!0,t._a[Pt]=0),t._d=(t._useUTC?J:function(e,t,n,s,i,r,a){var o=new Date(e,t,n,s,i,r,a);return e<100&&e>=0&&isFinite(o.getFullYear())&&o.setFullYear(e),o}).apply(null,o),r=t._useUTC?t._d.getUTCDay():t._d.getDay(),null!=t._tzm&&t._d.setUTCMinutes(t._d.getUTCMinutes()-t._tzm),t._nextDay&&(t._a[Pt]=24),t._w&&void 0!==t._w.d&&t._w.d!==r&&(d(t).weekdayMismatch=!0)}}function ce(e){var t,n,s,i,r,a,o=e._i,u=en.exec(o)||tn.exec(o);if(u){for(d(e).iso=!0,t=0,n=sn.length;t<n;t++)if(sn[t][1].exec(u[1])){i=sn[t][0],s=!1!==sn[t][2];break}if(null==i)return void(e._isValid=!1);if(u[3]){for(t=0,n=rn.length;t<n;t++)if(rn[t][1].exec(u[3])){r=(u[2]||" ")+rn[t][0];break}if(null==r)return void(e._isValid=!1)}if(!s&&null!=r)return void(e._isValid=!1);if(u[4]){if(!nn.exec(u[4]))return void(e._isValid=!1);a="Z"}e._f=i+(r||"")+(a||""),_e(e)}else e._isValid=!1}function fe(e,t,n,s,i,r){var a=[function(e){var t=parseInt(e,10);{if(t<=49)return 2e3+t;if(t<=999)return 1900+t}return t}(e),Vt.indexOf(t),parseInt(n,10),parseInt(s,10),parseInt(i,10)];return r&&a.push(parseInt(r,10)),a}function me(e){var t=on.exec(function(e){return e.replace(/\([^)]*\)|[\n\t]/g," ").replace(/(\s\s+)/g," ").trim()}(e._i));if(t){var n=fe(t[4],t[3],t[2],t[5],t[6],t[7]);if(!function(e,t,n){if(e&&jt.indexOf(e)!==new Date(t[0],t[1],t[2]).getDay())return d(n).weekdayMismatch=!0,n._isValid=!1,!1;return!0}(t[1],n,e))return;e._a=n,e._tzm=function(e,t,n){if(e)return un[e];if(t)return 0;var s=parseInt(n,10),i=s%100;return(s-i)/100*60+i}(t[8],t[9],t[10]),e._d=J.apply(null,e._a),e._d.setUTCMinutes(e._d.getUTCMinutes()-e._tzm),d(e).rfc2822=!0}else e._isValid=!1}function _e(t){if(t._f!==e.ISO_8601)if(t._f!==e.RFC_2822){t._a=[],d(t).empty=!0;var n,s,i,r,a,o=""+t._i,u=o.length,l=0;for(i=R(t._f,t._locale).match(rt)||[],n=0;n<i.length;n++)r=i[n],(s=(o.match(F(r,t))||[])[0])&&((a=o.substr(0,o.indexOf(s))).length>0&&d(t).unusedInput.push(a),o=o.slice(o.indexOf(s)+s.length),l+=s.length),ut[r]?(s?d(t).empty=!1:d(t).unusedTokens.push(r),G(r,s,t)):t._strict&&!s&&d(t).unusedTokens.push(r);d(t).charsLeftOver=u-l,o.length>0&&d(t).unusedInput.push(o),t._a[Pt]<=12&&!0===d(t).bigHour&&t._a[Pt]>0&&(d(t).bigHour=void 0),d(t).parsedDateParts=t._a.slice(0),d(t).meridiem=t._meridiem,t._a[Pt]=function(e,t,n){var s;if(null==n)return t;return null!=e.meridiemHour?e.meridiemHour(t,n):null!=e.isPM?((s=e.isPM(n))&&t<12&&(t+=12),s||12!==t||(t=0),t):t}(t._locale,t._a[Pt],t._meridiem),he(t),le(t)}else me(t);else ce(t)}function ye(o){var l=o._i,y=o._f;return o._locale=o._locale||ue(o._l),null===l||void 0===y&&""===l?c({nullInput:!0}):("string"==typeof l&&(o._i=l=o._locale.preparse(l)),_(l)?new m(le(l)):(r(l)?o._d=l:t(y)?function(e){var t,n,s,i,r;if(0===e._f.length)return d(e).invalidFormat=!0,void(e._d=new Date(NaN));for(i=0;i<e._f.length;i++)r=0,t=f({},e),null!=e._useUTC&&(t._useUTC=e._useUTC),t._f=e._f[i],_e(t),h(t)&&(r+=d(t).charsLeftOver,r+=10*d(t).unusedTokens.length,d(t).score=r,(null==s||r<s)&&(s=r,n=t));u(e,n||t)}(o):y?_e(o):function(o){var u=o._i;s(u)?o._d=new Date(e.now()):r(u)?o._d=new Date(u.valueOf()):"string"==typeof u?function(t){var n=an.exec(t._i);null===n?(ce(t),!1===t._isValid&&(delete t._isValid,me(t),!1===t._isValid&&(delete t._isValid,e.createFromInputFallback(t)))):t._d=new Date(+n[1])}(o):t(u)?(o._a=a(u.slice(0),function(e){return parseInt(e,10)}),he(o)):n(u)?function(e){if(!e._d){var t=T(e._i);e._a=a([t.year,t.month,t.day||t.date,t.hour,t.minute,t.second,t.millisecond],function(e){return e&&parseInt(e,10)}),he(e)}}(o):i(u)?o._d=new Date(u):e.createFromInputFallback(o)}(o),h(o)||(o._d=null),o))}function ge(e,s,i,r,a){var o={};return!0!==i&&!1!==i||(r=i,i=void 0),(n(e)&&function(e){if(Object.getOwnPropertyNames)return 0===Object.getOwnPropertyNames(e).length;var t;for(t in e)if(e.hasOwnProperty(t))return!1;return!0}(e)||t(e)&&0===e.length)&&(e=void 0),o._isAMomentObject=!0,o._useUTC=o._isUTC=a,o._l=i,o._i=e,o._f=s,o._strict=r,function(e){var t=new m(le(ye(e)));return t._nextDay&&(t.add(1,"d"),t._nextDay=void 0),t}(o)}function pe(e,t,n,s){return ge(e,t,n,s,!1)}function we(e,n){var s,i;if(1===n.length&&t(n[0])&&(n=n[0]),!n.length)return pe();for(s=n[0],i=1;i<n.length;++i)n[i].isValid()&&!n[i][e](s)||(s=n[i]);return s}function ve(e){var t=T(e),n=t.year||0,s=t.quarter||0,i=t.month||0,r=t.week||0,a=t.day||0,o=t.hour||0,u=t.minute||0,l=t.second||0,d=t.millisecond||0;this._isValid=function(e){for(var t in e)if(-1===Ut.call(hn,t)||null!=e[t]&&isNaN(e[t]))return!1;for(var n=!1,s=0;s<hn.length;++s)if(e[hn[s]]){if(n)return!1;parseFloat(e[hn[s]])!==g(e[hn[s]])&&(n=!0)}return!0}(t),this._milliseconds=+d+1e3*l+6e4*u+1e3*o*60*60,this._days=+a+7*r,this._months=+i+3*s+12*n,this._data={},this._locale=ue(),this._bubble()}function Me(e){return e instanceof ve}function Se(e){return e<0?-1*Math.round(-1*e):Math.round(e)}function De(e,t){P(e,0,0,function(){var e=this.utcOffset(),n="+";return e<0&&(e=-e,n="-"),n+b(~~(e/60),2)+t+b(~~e%60,2)})}function ke(e,t){var n=(t||"").match(e);if(null===n)return null;var s=((n[n.length-1]||[])+"").match(cn)||["-",0,0],i=60*s[1]+g(s[2]);return 0===i?0:"+"===s[0]?i:-i}function Ye(t,n){var s,i;return n._isUTC?(s=n.clone(),i=(_(t)||r(t)?t.valueOf():pe(t).valueOf())-s.valueOf(),s._d.setTime(s._d.valueOf()+i),e.updateOffset(s,!1),s):pe(t).local()}function Oe(e){return 15*-Math.round(e._d.getTimezoneOffset()/15)}function Te(){return!!this.isValid()&&(this._isUTC&&0===this._offset)}function xe(e,t){var n,s,r,a=e,u=null;return Me(e)?a={ms:e._milliseconds,d:e._days,M:e._months}:i(e)?(a={},t?a[t]=e:a.milliseconds=e):(u=fn.exec(e))?(n="-"===u[1]?-1:1,a={y:0,d:g(u[bt])*n,h:g(u[Pt])*n,m:g(u[Wt])*n,s:g(u[Ht])*n,ms:g(Se(1e3*u[Rt]))*n}):(u=mn.exec(e))?(n="-"===u[1]?-1:(u[1],1),a={y:be(u[2],n),M:be(u[3],n),w:be(u[4],n),d:be(u[5],n),h:be(u[6],n),m:be(u[7],n),s:be(u[8],n)}):null==a?a={}:"object"==typeof a&&("from"in a||"to"in a)&&(r=function(e,t){var n;if(!e.isValid()||!t.isValid())return{milliseconds:0,months:0};t=Ye(t,e),e.isBefore(t)?n=Pe(e,t):((n=Pe(t,e)).milliseconds=-n.milliseconds,n.months=-n.months);return n}(pe(a.from),pe(a.to)),(a={}).ms=r.milliseconds,a.M=r.months),s=new ve(a),Me(e)&&o(e,"_locale")&&(s._locale=e._locale),s}function be(e,t){var n=e&&parseFloat(e.replace(",","."));return(isNaN(n)?0:n)*t}function Pe(e,t){var n={milliseconds:0,months:0};return n.months=t.month()-e.month()+12*(t.year()-e.year()),e.clone().add(n.months,"M").isAfter(t)&&--n.months,n.milliseconds=+t-+e.clone().add(n.months,"M"),n}function We(e,t){return function(n,s){var i,r;return null===s||isNaN(+s)||(M(t,"moment()."+t+"(period, number) is deprecated. Please use moment()."+t+"(number, period). See http://momentjs.com/guides/#/warnings/add-inverted-param/ for more info."),r=n,n=s,s=r),n="string"==typeof n?+n:n,i=xe(n,s),He(this,i,e),this}}function He(t,n,s,i){var r=n._milliseconds,a=Se(n._days),o=Se(n._months);t.isValid()&&(i=null==i||i,o&&z(t,A(t,"Month")+o*s),a&&j(t,"Date",A(t,"Date")+a*s),r&&t._d.setTime(t._d.valueOf()+r*s),i&&e.updateOffset(t,a||o))}function Re(e,t){var n,s=12*(t.year()-e.year())+(t.month()-e.month()),i=e.clone().add(s,"months");return n=t-i<0?(t-i)/(i-e.clone().add(s-1,"months")):(t-i)/(e.clone().add(s+1,"months")-i),-(s+n)||0}function Ce(e){var t;return void 0===e?this._locale._abbr:(null!=(t=ue(e))&&(this._locale=t),this)}function Fe(){return this._locale}function Ue(e,t){P(0,[e,e.length],0,t)}function Le(e,t,n,s,i){var r;return null==e?X(this,s,i).year:(r=K(e,s,i),t>r&&(t=r),function(e,t,n,s,i){var r=Q(e,t,n,s,i),a=J(r.year,0,r.dayOfYear);return this.year(a.getUTCFullYear()),this.month(a.getUTCMonth()),this.date(a.getUTCDate()),this}.call(this,e,t,n,s,i))}function Ne(e,t){t[Rt]=g(1e3*("0."+e))}function Ge(e){return e}function Ve(e,t,n,s){var i=ue(),r=l().set(s,t);return i[n](r,e)}function Ee(e,t,n){if(i(e)&&(t=e,e=void 0),e=e||"",null!=t)return Ve(e,t,n,"month");var s,r=[];for(s=0;s<12;s++)r[s]=Ve(e,s,n,"month");return r}function Ie(e,t,n,s){"boolean"==typeof e?(i(t)&&(n=t,t=void 0),t=t||""):(n=t=e,e=!1,i(t)&&(n=t,t=void 0),t=t||"");var r=ue(),a=e?r._week.dow:0;if(null!=n)return Ve(t,(n+a)%7,s,"day");var o,u=[];for(o=0;o<7;o++)u[o]=Ve(t,(o+a)%7,s,"day");return u}function Ae(e,t,n,s){var i=xe(t,n);return e._milliseconds+=s*i._milliseconds,e._days+=s*i._days,e._months+=s*i._months,e._bubble()}function je(e){return e<0?Math.floor(e):Math.ceil(e)}function Ze(e){return 4800*e/146097}function ze(e){return 146097*e/4800}function $e(e){return function(){return this.as(e)}}function qe(e){return function(){return this.isValid()?this._data[e]:NaN}}function Je(e){return(e>0)-(e<0)||+e}function Be(){if(!this.isValid())return this.localeData().invalidDate();var e,t,n=An(this._milliseconds)/1e3,s=An(this._days),i=An(this._months);t=y((e=y(n/60))/60),n%=60,e%=60;var r=y(i/12),a=i%=12,o=s,u=t,l=e,d=n?n.toFixed(3).replace(/\.?0+$/,""):"",h=this.asSeconds();if(!h)return"P0D";var c=h<0?"-":"",f=Je(this._months)!==Je(h)?"-":"",m=Je(this._days)!==Je(h)?"-":"",_=Je(this._milliseconds)!==Je(h)?"-":"";return c+"P"+(r?f+r+"Y":"")+(a?f+a+"M":"")+(o?m+o+"D":"")+(u||l||d?"T":"")+(u?_+u+"H":"")+(l?_+l+"M":"")+(d?_+d+"S":"")}var Qe,Xe;Xe=Array.prototype.some?Array.prototype.some:function(e){for(var t=Object(this),n=t.length>>>0,s=0;s<n;s++)if(s in t&&e.call(this,t[s],s,t))return!0;return!1};var Ke=e.momentProperties=[],et=!1,tt={};e.suppressDeprecationWarnings=!1,e.deprecationHandler=null;var nt;nt=Object.keys?Object.keys:function(e){var t,n=[];for(t in e)o(e,t)&&n.push(t);return n};var st={},it={},rt=/(\[[^\[]*\])|(\\)?([Hh]mm(ss)?|Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Qo?|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|kk?|mm?|ss?|S{1,9}|x|X|zz?|ZZ?|.)/g,at=/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g,ot={},ut={},lt=/\d/,dt=/\d\d/,ht=/\d{3}/,ct=/\d{4}/,ft=/[+-]?\d{6}/,mt=/\d\d?/,_t=/\d\d\d\d?/,yt=/\d\d\d\d\d\d?/,gt=/\d{1,3}/,pt=/\d{1,4}/,wt=/[+-]?\d{1,6}/,vt=/\d+/,Mt=/[+-]?\d+/,St=/Z|[+-]\d\d:?\d\d/gi,Dt=/Z|[+-]\d\d(?::?\d\d)?/gi,kt=/[0-9]{0,256}['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFF07\uFF10-\uFFEF]{1,256}|[\u0600-\u06FF\/]{1,256}(\s*?[\u0600-\u06FF]{1,256}){1,2}/i,Yt={},Ot={},Tt=0,xt=1,bt=2,Pt=3,Wt=4,Ht=5,Rt=6,Ct=7,Ft=8;P("Y",0,0,function(){var e=this.year();return e<=9999?""+e:"+"+e}),P(0,["YY",2],0,function(){return this.year()%100}),P(0,["YYYY",4],0,"year"),P(0,["YYYYY",5],0,"year"),P(0,["YYYYYY",6,!0],0,"year"),Y("year","y"),x("year",1),C("Y",Mt),C("YY",mt,dt),C("YYYY",pt,ct),C("YYYYY",wt,ft),C("YYYYYY",wt,ft),L(["YYYYY","YYYYYY"],Tt),L("YYYY",function(t,n){n[Tt]=2===t.length?e.parseTwoDigitYear(t):g(t)}),L("YY",function(t,n){n[Tt]=e.parseTwoDigitYear(t)}),L("Y",function(e,t){t[Tt]=parseInt(e,10)}),e.parseTwoDigitYear=function(e){return g(e)+(g(e)>68?1900:2e3)};var Ut,Lt=I("FullYear",!0);Ut=Array.prototype.indexOf?Array.prototype.indexOf:function(e){var t;for(t=0;t<this.length;++t)if(this[t]===e)return t;return-1},P("M",["MM",2],"Mo",function(){return this.month()+1}),P("MMM",0,0,function(e){return this.localeData().monthsShort(this,e)}),P("MMMM",0,0,function(e){return this.localeData().months(this,e)}),Y("month","M"),x("month",8),C("M",mt),C("MM",mt,dt),C("MMM",function(e,t){return t.monthsShortRegex(e)}),C("MMMM",function(e,t){return t.monthsRegex(e)}),L(["M","MM"],function(e,t){t[xt]=g(e)-1}),L(["MMM","MMMM"],function(e,t,n,s){var i=n._locale.monthsParse(e,s,n._strict);null!=i?t[xt]=i:d(n).invalidMonth=e});var Nt=/D[oD]?(\[[^\[\]]*\]|\s)+MMMM?/,Gt="January_February_March_April_May_June_July_August_September_October_November_December".split("_"),Vt="Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),Et=kt,It=kt;P("w",["ww",2],"wo","week"),P("W",["WW",2],"Wo","isoWeek"),Y("week","w"),Y("isoWeek","W"),x("week",5),x("isoWeek",5),C("w",mt),C("ww",mt,dt),C("W",mt),C("WW",mt,dt),N(["w","ww","W","WW"],function(e,t,n,s){t[s.substr(0,1)]=g(e)});P("d",0,"do","day"),P("dd",0,0,function(e){return this.localeData().weekdaysMin(this,e)}),P("ddd",0,0,function(e){return this.localeData().weekdaysShort(this,e)}),P("dddd",0,0,function(e){return this.localeData().weekdays(this,e)}),P("e",0,0,"weekday"),P("E",0,0,"isoWeekday"),Y("day","d"),Y("weekday","e"),Y("isoWeekday","E"),x("day",11),x("weekday",11),x("isoWeekday",11),C("d",mt),C("e",mt),C("E",mt),C("dd",function(e,t){return t.weekdaysMinRegex(e)}),C("ddd",function(e,t){return t.weekdaysShortRegex(e)}),C("dddd",function(e,t){return t.weekdaysRegex(e)}),N(["dd","ddd","dddd"],function(e,t,n,s){var i=n._locale.weekdaysParse(e,s,n._strict);null!=i?t.d=i:d(n).invalidWeekday=e}),N(["d","e","E"],function(e,t,n,s){t[s]=g(e)});var At="Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),jt="Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),Zt="Su_Mo_Tu_We_Th_Fr_Sa".split("_"),zt=kt,$t=kt,qt=kt;P("H",["HH",2],0,"hour"),P("h",["hh",2],0,te),P("k",["kk",2],0,function(){return this.hours()||24}),P("hmm",0,0,function(){return""+te.apply(this)+b(this.minutes(),2)}),P("hmmss",0,0,function(){return""+te.apply(this)+b(this.minutes(),2)+b(this.seconds(),2)}),P("Hmm",0,0,function(){return""+this.hours()+b(this.minutes(),2)}),P("Hmmss",0,0,function(){return""+this.hours()+b(this.minutes(),2)+b(this.seconds(),2)}),ne("a",!0),ne("A",!1),Y("hour","h"),x("hour",13),C("a",se),C("A",se),C("H",mt),C("h",mt),C("k",mt),C("HH",mt,dt),C("hh",mt,dt),C("kk",mt,dt),C("hmm",_t),C("hmmss",yt),C("Hmm",_t),C("Hmmss",yt),L(["H","HH"],Pt),L(["k","kk"],function(e,t,n){var s=g(e);t[Pt]=24===s?0:s}),L(["a","A"],function(e,t,n){n._isPm=n._locale.isPM(e),n._meridiem=e}),L(["h","hh"],function(e,t,n){t[Pt]=g(e),d(n).bigHour=!0}),L("hmm",function(e,t,n){var s=e.length-2;t[Pt]=g(e.substr(0,s)),t[Wt]=g(e.substr(s)),d(n).bigHour=!0}),L("hmmss",function(e,t,n){var s=e.length-4,i=e.length-2;t[Pt]=g(e.substr(0,s)),t[Wt]=g(e.substr(s,2)),t[Ht]=g(e.substr(i)),d(n).bigHour=!0}),L("Hmm",function(e,t,n){var s=e.length-2;t[Pt]=g(e.substr(0,s)),t[Wt]=g(e.substr(s))}),L("Hmmss",function(e,t,n){var s=e.length-4,i=e.length-2;t[Pt]=g(e.substr(0,s)),t[Wt]=g(e.substr(s,2)),t[Ht]=g(e.substr(i))});var Jt,Bt=I("Hours",!0),Qt={calendar:{sameDay:"[Today at] LT",nextDay:"[Tomorrow at] LT",nextWeek:"dddd [at] LT",lastDay:"[Yesterday at] LT",lastWeek:"[Last] dddd [at] LT",sameElse:"L"},longDateFormat:{LTS:"h:mm:ss A",LT:"h:mm A",L:"MM/DD/YYYY",LL:"MMMM D, YYYY",LLL:"MMMM D, YYYY h:mm A",LLLL:"dddd, MMMM D, YYYY h:mm A"},invalidDate:"Invalid date",ordinal:"%d",dayOfMonthOrdinalParse:/\d{1,2}/,relativeTime:{future:"in %s",past:"%s ago",s:"a few seconds",ss:"%d seconds",m:"a minute",mm:"%d minutes",h:"an hour",hh:"%d hours",d:"a day",dd:"%d days",M:"a month",MM:"%d months",y:"a year",yy:"%d years"},months:Gt,monthsShort:Vt,week:{dow:0,doy:6},weekdays:At,weekdaysMin:Zt,weekdaysShort:jt,meridiemParse:/[ap]\.?m?\.?/i},Xt={},Kt={},en=/^\s*((?:[+-]\d{6}|\d{4})-(?:\d\d-\d\d|W\d\d-\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?::\d\d(?::\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,tn=/^\s*((?:[+-]\d{6}|\d{4})(?:\d\d\d\d|W\d\d\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?:\d\d(?:\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,nn=/Z|[+-]\d\d(?::?\d\d)?/,sn=[["YYYYYY-MM-DD",/[+-]\d{6}-\d\d-\d\d/],["YYYY-MM-DD",/\d{4}-\d\d-\d\d/],["GGGG-[W]WW-E",/\d{4}-W\d\d-\d/],["GGGG-[W]WW",/\d{4}-W\d\d/,!1],["YYYY-DDD",/\d{4}-\d{3}/],["YYYY-MM",/\d{4}-\d\d/,!1],["YYYYYYMMDD",/[+-]\d{10}/],["YYYYMMDD",/\d{8}/],["GGGG[W]WWE",/\d{4}W\d{3}/],["GGGG[W]WW",/\d{4}W\d{2}/,!1],["YYYYDDD",/\d{7}/]],rn=[["HH:mm:ss.SSSS",/\d\d:\d\d:\d\d\.\d+/],["HH:mm:ss,SSSS",/\d\d:\d\d:\d\d,\d+/],["HH:mm:ss",/\d\d:\d\d:\d\d/],["HH:mm",/\d\d:\d\d/],["HHmmss.SSSS",/\d\d\d\d\d\d\.\d+/],["HHmmss,SSSS",/\d\d\d\d\d\d,\d+/],["HHmmss",/\d\d\d\d\d\d/],["HHmm",/\d\d\d\d/],["HH",/\d\d/]],an=/^\/?Date\((\-?\d+)/i,on=/^(?:(Mon|Tue|Wed|Thu|Fri|Sat|Sun),?\s)?(\d{1,2})\s(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s(\d{2,4})\s(\d\d):(\d\d)(?::(\d\d))?\s(?:(UT|GMT|[ECMP][SD]T)|([Zz])|([+-]\d{4}))$/,un={UT:0,GMT:0,EDT:-240,EST:-300,CDT:-300,CST:-360,MDT:-360,MST:-420,PDT:-420,PST:-480};e.createFromInputFallback=v("value provided is not in a recognized RFC2822 or ISO format. moment construction falls back to js Date(), which is not reliable across all browsers and versions. Non RFC2822/ISO date formats are discouraged and will be removed in an upcoming major release. Please refer to http://momentjs.com/guides/#/warnings/js-date/ for more info.",function(e){e._d=new Date(e._i+(e._useUTC?" UTC":""))}),e.ISO_8601=function(){},e.RFC_2822=function(){};var ln=v("moment().min is deprecated, use moment.max instead. http://momentjs.com/guides/#/warnings/min-max/",function(){var e=pe.apply(null,arguments);return this.isValid()&&e.isValid()?e<this?this:e:c()}),dn=v("moment().max is deprecated, use moment.min instead. http://momentjs.com/guides/#/warnings/min-max/",function(){var e=pe.apply(null,arguments);return this.isValid()&&e.isValid()?e>this?this:e:c()}),hn=["year","quarter","month","week","day","hour","minute","second","millisecond"];De("Z",":"),De("ZZ",""),C("Z",Dt),C("ZZ",Dt),L(["Z","ZZ"],function(e,t,n){n._useUTC=!0,n._tzm=ke(Dt,e)});var cn=/([\+\-]|\d\d)/gi;e.updateOffset=function(){};var fn=/^(\-|\+)?(?:(\d*)[. ])?(\d+)\:(\d+)(?:\:(\d+)(\.\d*)?)?$/,mn=/^(-|\+)?P(?:([-+]?[0-9,.]*)Y)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)W)?(?:([-+]?[0-9,.]*)D)?(?:T(?:([-+]?[0-9,.]*)H)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)S)?)?$/;xe.fn=ve.prototype,xe.invalid=function(){return xe(NaN)};var _n=We(1,"add"),yn=We(-1,"subtract");e.defaultFormat="YYYY-MM-DDTHH:mm:ssZ",e.defaultFormatUtc="YYYY-MM-DDTHH:mm:ss[Z]";var gn=v("moment().lang() is deprecated. Instead, use moment().localeData() to get the language configuration. Use moment().locale() to change languages.",function(e){return void 0===e?this.localeData():this.locale(e)});P(0,["gg",2],0,function(){return this.weekYear()%100}),P(0,["GG",2],0,function(){return this.isoWeekYear()%100}),Ue("gggg","weekYear"),Ue("ggggg","weekYear"),Ue("GGGG","isoWeekYear"),Ue("GGGGG","isoWeekYear"),Y("weekYear","gg"),Y("isoWeekYear","GG"),x("weekYear",1),x("isoWeekYear",1),C("G",Mt),C("g",Mt),C("GG",mt,dt),C("gg",mt,dt),C("GGGG",pt,ct),C("gggg",pt,ct),C("GGGGG",wt,ft),C("ggggg",wt,ft),N(["gggg","ggggg","GGGG","GGGGG"],function(e,t,n,s){t[s.substr(0,2)]=g(e)}),N(["gg","GG"],function(t,n,s,i){n[i]=e.parseTwoDigitYear(t)}),P("Q",0,"Qo","quarter"),Y("quarter","Q"),x("quarter",7),C("Q",lt),L("Q",function(e,t){t[xt]=3*(g(e)-1)}),P("D",["DD",2],"Do","date"),Y("date","D"),x("date",9),C("D",mt),C("DD",mt,dt),C("Do",function(e,t){return e?t._dayOfMonthOrdinalParse||t._ordinalParse:t._dayOfMonthOrdinalParseLenient}),L(["D","DD"],bt),L("Do",function(e,t){t[bt]=g(e.match(mt)[0])});var pn=I("Date",!0);P("DDD",["DDDD",3],"DDDo","dayOfYear"),Y("dayOfYear","DDD"),x("dayOfYear",4),C("DDD",gt),C("DDDD",ht),L(["DDD","DDDD"],function(e,t,n){n._dayOfYear=g(e)}),P("m",["mm",2],0,"minute"),Y("minute","m"),x("minute",14),C("m",mt),C("mm",mt,dt),L(["m","mm"],Wt);var wn=I("Minutes",!1);P("s",["ss",2],0,"second"),Y("second","s"),x("second",15),C("s",mt),C("ss",mt,dt),L(["s","ss"],Ht);var vn=I("Seconds",!1);P("S",0,0,function(){return~~(this.millisecond()/100)}),P(0,["SS",2],0,function(){return~~(this.millisecond()/10)}),P(0,["SSS",3],0,"millisecond"),P(0,["SSSS",4],0,function(){return 10*this.millisecond()}),P(0,["SSSSS",5],0,function(){return 100*this.millisecond()}),P(0,["SSSSSS",6],0,function(){return 1e3*this.millisecond()}),P(0,["SSSSSSS",7],0,function(){return 1e4*this.millisecond()}),P(0,["SSSSSSSS",8],0,function(){return 1e5*this.millisecond()}),P(0,["SSSSSSSSS",9],0,function(){return 1e6*this.millisecond()}),Y("millisecond","ms"),x("millisecond",16),C("S",gt,lt),C("SS",gt,dt),C("SSS",gt,ht);var Mn;for(Mn="SSSS";Mn.length<=9;Mn+="S")C(Mn,vt);for(Mn="S";Mn.length<=9;Mn+="S")L(Mn,Ne);var Sn=I("Milliseconds",!1);P("z",0,0,"zoneAbbr"),P("zz",0,0,"zoneName");var Dn=m.prototype;Dn.add=_n,Dn.calendar=function(t,n){var s=t||pe(),i=Ye(s,this).startOf("day"),r=e.calendarFormat(this,i)||"sameElse",a=n&&(S(n[r])?n[r].call(this,s):n[r]);return this.format(a||this.localeData().calendar(r,this,pe(s)))},Dn.clone=function(){return new m(this)},Dn.diff=function(e,t,n){var s,i,r;if(!this.isValid())return NaN;if(!(s=Ye(e,this)).isValid())return NaN;switch(i=6e4*(s.utcOffset()-this.utcOffset()),t=O(t)){case"year":r=Re(this,s)/12;break;case"month":r=Re(this,s);break;case"quarter":r=Re(this,s)/3;break;case"second":r=(this-s)/1e3;break;case"minute":r=(this-s)/6e4;break;case"hour":r=(this-s)/36e5;break;case"day":r=(this-s-i)/864e5;break;case"week":r=(this-s-i)/6048e5;break;default:r=this-s}return n?r:y(r)},Dn.endOf=function(e){return void 0===(e=O(e))||"millisecond"===e?this:("date"===e&&(e="day"),this.startOf(e).add(1,"isoWeek"===e?"week":e).subtract(1,"ms"))},Dn.format=function(t){t||(t=this.isUtc()?e.defaultFormatUtc:e.defaultFormat);var n=H(this,t);return this.localeData().postformat(n)},Dn.from=function(e,t){return this.isValid()&&(_(e)&&e.isValid()||pe(e).isValid())?xe({to:this,from:e}).locale(this.locale()).humanize(!t):this.localeData().invalidDate()},Dn.fromNow=function(e){return this.from(pe(),e)},Dn.to=function(e,t){return this.isValid()&&(_(e)&&e.isValid()||pe(e).isValid())?xe({from:this,to:e}).locale(this.locale()).humanize(!t):this.localeData().invalidDate()},Dn.toNow=function(e){return this.to(pe(),e)},Dn.get=function(e){return e=O(e),S(this[e])?this[e]():this},Dn.invalidAt=function(){return d(this).overflow},Dn.isAfter=function(e,t){var n=_(e)?e:pe(e);return!(!this.isValid()||!n.isValid())&&("millisecond"===(t=O(s(t)?"millisecond":t))?this.valueOf()>n.valueOf():n.valueOf()<this.clone().startOf(t).valueOf())},Dn.isBefore=function(e,t){var n=_(e)?e:pe(e);return!(!this.isValid()||!n.isValid())&&("millisecond"===(t=O(s(t)?"millisecond":t))?this.valueOf()<n.valueOf():this.clone().endOf(t).valueOf()<n.valueOf())},Dn.isBetween=function(e,t,n,s){return("("===(s=s||"()")[0]?this.isAfter(e,n):!this.isBefore(e,n))&&(")"===s[1]?this.isBefore(t,n):!this.isAfter(t,n))},Dn.isSame=function(e,t){var n,s=_(e)?e:pe(e);return!(!this.isValid()||!s.isValid())&&("millisecond"===(t=O(t||"millisecond"))?this.valueOf()===s.valueOf():(n=s.valueOf(),this.clone().startOf(t).valueOf()<=n&&n<=this.clone().endOf(t).valueOf()))},Dn.isSameOrAfter=function(e,t){return this.isSame(e,t)||this.isAfter(e,t)},Dn.isSameOrBefore=function(e,t){return this.isSame(e,t)||this.isBefore(e,t)},Dn.isValid=function(){return h(this)},Dn.lang=gn,Dn.locale=Ce,Dn.localeData=Fe,Dn.max=dn,Dn.min=ln,Dn.parsingFlags=function(){return u({},d(this))},Dn.set=function(e,t){if("object"==typeof e)for(var n=function(e){var t=[];for(var n in e)t.push({unit:n,priority:it[n]});return t.sort(function(e,t){return e.priority-t.priority}),t}(e=T(e)),s=0;s<n.length;s++)this[n[s].unit](e[n[s].unit]);else if(e=O(e),S(this[e]))return this[e](t);return this},Dn.startOf=function(e){switch(e=O(e)){case"year":this.month(0);case"quarter":case"month":this.date(1);case"week":case"isoWeek":case"day":case"date":this.hours(0);case"hour":this.minutes(0);case"minute":this.seconds(0);case"second":this.milliseconds(0)}return"week"===e&&this.weekday(0),"isoWeek"===e&&this.isoWeekday(1),"quarter"===e&&this.month(3*Math.floor(this.month()/3)),this},Dn.subtract=yn,Dn.toArray=function(){return[this.year(),this.month(),this.date(),this.hour(),this.minute(),this.second(),this.millisecond()]},Dn.toObject=function(){return{years:this.year(),months:this.month(),date:this.date(),hours:this.hours(),minutes:this.minutes(),seconds:this.seconds(),milliseconds:this.milliseconds()}},Dn.toDate=function(){return new Date(this.valueOf())},Dn.toISOString=function(e){if(!this.isValid())return null;var t=!0!==e,n=t?this.clone().utc():this;return n.year()<0||n.year()>9999?H(n,t?"YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]":"YYYYYY-MM-DD[T]HH:mm:ss.SSSZ"):S(Date.prototype.toISOString)?t?this.toDate().toISOString():new Date(this._d.valueOf()).toISOString().replace("Z",H(n,"Z")):H(n,t?"YYYY-MM-DD[T]HH:mm:ss.SSS[Z]":"YYYY-MM-DD[T]HH:mm:ss.SSSZ")},Dn.inspect=function(){if(!this.isValid())return"moment.invalid(/* "+this._i+" */)";var e="moment",t="";this.isLocal()||(e=0===this.utcOffset()?"moment.utc":"moment.parseZone",t="Z");var n="["+e+'("]',s=0<=this.year()&&this.year()<=9999?"YYYY":"YYYYYY",i=t+'[")]';return this.format(n+s+"-MM-DD[T]HH:mm:ss.SSS"+i)},Dn.toJSON=function(){return this.isValid()?this.toISOString():null},Dn.toString=function(){return this.clone().locale("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ")},Dn.unix=function(){return Math.floor(this.valueOf()/1e3)},Dn.valueOf=function(){return this._d.valueOf()-6e4*(this._offset||0)},Dn.creationData=function(){return{input:this._i,format:this._f,locale:this._locale,isUTC:this._isUTC,strict:this._strict}},Dn.year=Lt,Dn.isLeapYear=function(){return E(this.year())},Dn.weekYear=function(e){return Le.call(this,e,this.week(),this.weekday(),this.localeData()._week.dow,this.localeData()._week.doy)},Dn.isoWeekYear=function(e){return Le.call(this,e,this.isoWeek(),this.isoWeekday(),1,4)},Dn.quarter=Dn.quarters=function(e){return null==e?Math.ceil((this.month()+1)/3):this.month(3*(e-1)+this.month()%3)},Dn.month=$,Dn.daysInMonth=function(){return Z(this.year(),this.month())},Dn.week=Dn.weeks=function(e){var t=this.localeData().week(this);return null==e?t:this.add(7*(e-t),"d")},Dn.isoWeek=Dn.isoWeeks=function(e){var t=X(this,1,4).week;return null==e?t:this.add(7*(e-t),"d")},Dn.weeksInYear=function(){var e=this.localeData()._week;return K(this.year(),e.dow,e.doy)},Dn.isoWeeksInYear=function(){return K(this.year(),1,4)},Dn.date=pn,Dn.day=Dn.days=function(e){if(!this.isValid())return null!=e?this:NaN;var t=this._isUTC?this._d.getUTCDay():this._d.getDay();return null!=e?(e=function(e,t){return"string"!=typeof e?e:isNaN(e)?"number"==typeof(e=t.weekdaysParse(e))?e:null:parseInt(e,10)}(e,this.localeData()),this.add(e-t,"d")):t},Dn.weekday=function(e){if(!this.isValid())return null!=e?this:NaN;var t=(this.day()+7-this.localeData()._week.dow)%7;return null==e?t:this.add(e-t,"d")},Dn.isoWeekday=function(e){if(!this.isValid())return null!=e?this:NaN;if(null!=e){var t=function(e,t){return"string"==typeof e?t.weekdaysParse(e)%7||7:isNaN(e)?null:e}(e,this.localeData());return this.day(this.day()%7?t:t-7)}return this.day()||7},Dn.dayOfYear=function(e){var t=Math.round((this.clone().startOf("day")-this.clone().startOf("year"))/864e5)+1;return null==e?t:this.add(e-t,"d")},Dn.hour=Dn.hours=Bt,Dn.minute=Dn.minutes=wn,Dn.second=Dn.seconds=vn,Dn.millisecond=Dn.milliseconds=Sn,Dn.utcOffset=function(t,n,s){var i,r=this._offset||0;if(!this.isValid())return null!=t?this:NaN;if(null!=t){if("string"==typeof t){if(null===(t=ke(Dt,t)))return this}else Math.abs(t)<16&&!s&&(t*=60);return!this._isUTC&&n&&(i=Oe(this)),this._offset=t,this._isUTC=!0,null!=i&&this.add(i,"m"),r!==t&&(!n||this._changeInProgress?He(this,xe(t-r,"m"),1,!1):this._changeInProgress||(this._changeInProgress=!0,e.updateOffset(this,!0),this._changeInProgress=null)),this}return this._isUTC?r:Oe(this)},Dn.utc=function(e){return this.utcOffset(0,e)},Dn.local=function(e){return this._isUTC&&(this.utcOffset(0,e),this._isUTC=!1,e&&this.subtract(Oe(this),"m")),this},Dn.parseZone=function(){if(null!=this._tzm)this.utcOffset(this._tzm,!1,!0);else if("string"==typeof this._i){var e=ke(St,this._i);null!=e?this.utcOffset(e):this.utcOffset(0,!0)}return this},Dn.hasAlignedHourOffset=function(e){return!!this.isValid()&&(e=e?pe(e).utcOffset():0,(this.utcOffset()-e)%60==0)},Dn.isDST=function(){return this.utcOffset()>this.clone().month(0).utcOffset()||this.utcOffset()>this.clone().month(5).utcOffset()},Dn.isLocal=function(){return!!this.isValid()&&!this._isUTC},Dn.isUtcOffset=function(){return!!this.isValid()&&this._isUTC},Dn.isUtc=Te,Dn.isUTC=Te,Dn.zoneAbbr=function(){return this._isUTC?"UTC":""},Dn.zoneName=function(){return this._isUTC?"Coordinated Universal Time":""},Dn.dates=v("dates accessor is deprecated. Use date instead.",pn),Dn.months=v("months accessor is deprecated. Use month instead",$),Dn.years=v("years accessor is deprecated. Use year instead",Lt),Dn.zone=v("moment().zone is deprecated, use moment().utcOffset instead. http://momentjs.com/guides/#/warnings/zone/",function(e,t){return null!=e?("string"!=typeof e&&(e=-e),this.utcOffset(e,t),this):-this.utcOffset()}),Dn.isDSTShifted=v("isDSTShifted is deprecated. See http://momentjs.com/guides/#/warnings/dst-shifted/ for more information",function(){if(!s(this._isDSTShifted))return this._isDSTShifted;var e={};if(f(e,this),(e=ye(e))._a){var t=e._isUTC?l(e._a):pe(e._a);this._isDSTShifted=this.isValid()&&p(e._a,t.toArray())>0}else this._isDSTShifted=!1;return this._isDSTShifted});var kn=k.prototype;kn.calendar=function(e,t,n){var s=this._calendar[e]||this._calendar.sameElse;return S(s)?s.call(t,n):s},kn.longDateFormat=function(e){var t=this._longDateFormat[e],n=this._longDateFormat[e.toUpperCase()];return t||!n?t:(this._longDateFormat[e]=n.replace(/MMMM|MM|DD|dddd/g,function(e){return e.slice(1)}),this._longDateFormat[e])},kn.invalidDate=function(){return this._invalidDate},kn.ordinal=function(e){return this._ordinal.replace("%d",e)},kn.preparse=Ge,kn.postformat=Ge,kn.relativeTime=function(e,t,n,s){var i=this._relativeTime[n];return S(i)?i(e,t,n,s):i.replace(/%d/i,e)},kn.pastFuture=function(e,t){var n=this._relativeTime[e>0?"future":"past"];return S(n)?n(t):n.replace(/%s/i,t)},kn.set=function(e){var t,n;for(n in e)S(t=e[n])?this[n]=t:this["_"+n]=t;this._config=e,this._dayOfMonthOrdinalParseLenient=new RegExp((this._dayOfMonthOrdinalParse.source||this._ordinalParse.source)+"|"+/\d{1,2}/.source)},kn.months=function(e,n){return e?t(this._months)?this._months[e.month()]:this._months[(this._months.isFormat||Nt).test(n)?"format":"standalone"][e.month()]:t(this._months)?this._months:this._months.standalone},kn.monthsShort=function(e,n){return e?t(this._monthsShort)?this._monthsShort[e.month()]:this._monthsShort[Nt.test(n)?"format":"standalone"][e.month()]:t(this._monthsShort)?this._monthsShort:this._monthsShort.standalone},kn.monthsParse=function(e,t,n){var s,i,r;if(this._monthsParseExact)return function(e,t,n){var s,i,r,a=e.toLocaleLowerCase();if(!this._monthsParse)for(this._monthsParse=[],this._longMonthsParse=[],this._shortMonthsParse=[],s=0;s<12;++s)r=l([2e3,s]),this._shortMonthsParse[s]=this.monthsShort(r,"").toLocaleLowerCase(),this._longMonthsParse[s]=this.months(r,"").toLocaleLowerCase();return n?"MMM"===t?-1!==(i=Ut.call(this._shortMonthsParse,a))?i:null:-1!==(i=Ut.call(this._longMonthsParse,a))?i:null:"MMM"===t?-1!==(i=Ut.call(this._shortMonthsParse,a))?i:-1!==(i=Ut.call(this._longMonthsParse,a))?i:null:-1!==(i=Ut.call(this._longMonthsParse,a))?i:-1!==(i=Ut.call(this._shortMonthsParse,a))?i:null}.call(this,e,t,n);for(this._monthsParse||(this._monthsParse=[],this._longMonthsParse=[],this._shortMonthsParse=[]),s=0;s<12;s++){if(i=l([2e3,s]),n&&!this._longMonthsParse[s]&&(this._longMonthsParse[s]=new RegExp("^"+this.months(i,"").replace(".","")+"$","i"),this._shortMonthsParse[s]=new RegExp("^"+this.monthsShort(i,"").replace(".","")+"$","i")),n||this._monthsParse[s]||(r="^"+this.months(i,"")+"|^"+this.monthsShort(i,""),this._monthsParse[s]=new RegExp(r.replace(".",""),"i")),n&&"MMMM"===t&&this._longMonthsParse[s].test(e))return s;if(n&&"MMM"===t&&this._shortMonthsParse[s].test(e))return s;if(!n&&this._monthsParse[s].test(e))return s}},kn.monthsRegex=function(e){return this._monthsParseExact?(o(this,"_monthsRegex")||q.call(this),e?this._monthsStrictRegex:this._monthsRegex):(o(this,"_monthsRegex")||(this._monthsRegex=It),this._monthsStrictRegex&&e?this._monthsStrictRegex:this._monthsRegex)},kn.monthsShortRegex=function(e){return this._monthsParseExact?(o(this,"_monthsRegex")||q.call(this),e?this._monthsShortStrictRegex:this._monthsShortRegex):(o(this,"_monthsShortRegex")||(this._monthsShortRegex=Et),this._monthsShortStrictRegex&&e?this._monthsShortStrictRegex:this._monthsShortRegex)},kn.week=function(e){return X(e,this._week.dow,this._week.doy).week},kn.firstDayOfYear=function(){return this._week.doy},kn.firstDayOfWeek=function(){return this._week.dow},kn.weekdays=function(e,n){return e?t(this._weekdays)?this._weekdays[e.day()]:this._weekdays[this._weekdays.isFormat.test(n)?"format":"standalone"][e.day()]:t(this._weekdays)?this._weekdays:this._weekdays.standalone},kn.weekdaysMin=function(e){return e?this._weekdaysMin[e.day()]:this._weekdaysMin},kn.weekdaysShort=function(e){return e?this._weekdaysShort[e.day()]:this._weekdaysShort},kn.weekdaysParse=function(e,t,n){var s,i,r;if(this._weekdaysParseExact)return function(e,t,n){var s,i,r,a=e.toLocaleLowerCase();if(!this._weekdaysParse)for(this._weekdaysParse=[],this._shortWeekdaysParse=[],this._minWeekdaysParse=[],s=0;s<7;++s)r=l([2e3,1]).day(s),this._minWeekdaysParse[s]=this.weekdaysMin(r,"").toLocaleLowerCase(),this._shortWeekdaysParse[s]=this.weekdaysShort(r,"").toLocaleLowerCase(),this._weekdaysParse[s]=this.weekdays(r,"").toLocaleLowerCase();return n?"dddd"===t?-1!==(i=Ut.call(this._weekdaysParse,a))?i:null:"ddd"===t?-1!==(i=Ut.call(this._shortWeekdaysParse,a))?i:null:-1!==(i=Ut.call(this._minWeekdaysParse,a))?i:null:"dddd"===t?-1!==(i=Ut.call(this._weekdaysParse,a))?i:-1!==(i=Ut.call(this._shortWeekdaysParse,a))?i:-1!==(i=Ut.call(this._minWeekdaysParse,a))?i:null:"ddd"===t?-1!==(i=Ut.call(this._shortWeekdaysParse,a))?i:-1!==(i=Ut.call(this._weekdaysParse,a))?i:-1!==(i=Ut.call(this._minWeekdaysParse,a))?i:null:-1!==(i=Ut.call(this._minWeekdaysParse,a))?i:-1!==(i=Ut.call(this._weekdaysParse,a))?i:-1!==(i=Ut.call(this._shortWeekdaysParse,a))?i:null}.call(this,e,t,n);for(this._weekdaysParse||(this._weekdaysParse=[],this._minWeekdaysParse=[],this._shortWeekdaysParse=[],this._fullWeekdaysParse=[]),s=0;s<7;s++){if(i=l([2e3,1]).day(s),n&&!this._fullWeekdaysParse[s]&&(this._fullWeekdaysParse[s]=new RegExp("^"+this.weekdays(i,"").replace(".",".?")+"$","i"),this._shortWeekdaysParse[s]=new RegExp("^"+this.weekdaysShort(i,"").replace(".",".?")+"$","i"),this._minWeekdaysParse[s]=new RegExp("^"+this.weekdaysMin(i,"").replace(".",".?")+"$","i")),this._weekdaysParse[s]||(r="^"+this.weekdays(i,"")+"|^"+this.weekdaysShort(i,"")+"|^"+this.weekdaysMin(i,""),this._weekdaysParse[s]=new RegExp(r.replace(".",""),"i")),n&&"dddd"===t&&this._fullWeekdaysParse[s].test(e))return s;if(n&&"ddd"===t&&this._shortWeekdaysParse[s].test(e))return s;if(n&&"dd"===t&&this._minWeekdaysParse[s].test(e))return s;if(!n&&this._weekdaysParse[s].test(e))return s}},kn.weekdaysRegex=function(e){return this._weekdaysParseExact?(o(this,"_weekdaysRegex")||ee.call(this),e?this._weekdaysStrictRegex:this._weekdaysRegex):(o(this,"_weekdaysRegex")||(this._weekdaysRegex=zt),this._weekdaysStrictRegex&&e?this._weekdaysStrictRegex:this._weekdaysRegex)},kn.weekdaysShortRegex=function(e){return this._weekdaysParseExact?(o(this,"_weekdaysRegex")||ee.call(this),e?this._weekdaysShortStrictRegex:this._weekdaysShortRegex):(o(this,"_weekdaysShortRegex")||(this._weekdaysShortRegex=$t),this._weekdaysShortStrictRegex&&e?this._weekdaysShortStrictRegex:this._weekdaysShortRegex)},kn.weekdaysMinRegex=function(e){return this._weekdaysParseExact?(o(this,"_weekdaysRegex")||ee.call(this),e?this._weekdaysMinStrictRegex:this._weekdaysMinRegex):(o(this,"_weekdaysMinRegex")||(this._weekdaysMinRegex=qt),this._weekdaysMinStrictRegex&&e?this._weekdaysMinStrictRegex:this._weekdaysMinRegex)},kn.isPM=function(e){return"p"===(e+"").toLowerCase().charAt(0)},kn.meridiem=function(e,t,n){return e>11?n?"pm":"PM":n?"am":"AM"},ae("en",{dayOfMonthOrdinalParse:/\d{1,2}(th|st|nd|rd)/,ordinal:function(e){var t=e%10;return e+(1===g(e%100/10)?"th":1===t?"st":2===t?"nd":3===t?"rd":"th")}}),e.lang=v("moment.lang is deprecated. Use moment.locale instead.",ae),e.langData=v("moment.langData is deprecated. Use moment.localeData instead.",ue);var Yn=Math.abs,On=$e("ms"),Tn=$e("s"),xn=$e("m"),bn=$e("h"),Pn=$e("d"),Wn=$e("w"),Hn=$e("M"),Rn=$e("y"),Cn=qe("milliseconds"),Fn=qe("seconds"),Un=qe("minutes"),Ln=qe("hours"),Nn=qe("days"),Gn=qe("months"),Vn=qe("years"),En=Math.round,In={ss:44,s:45,m:45,h:22,d:26,M:11},An=Math.abs,jn=ve.prototype;return jn.isValid=function(){return this._isValid},jn.abs=function(){var e=this._data;return this._milliseconds=Yn(this._milliseconds),this._days=Yn(this._days),this._months=Yn(this._months),e.milliseconds=Yn(e.milliseconds),e.seconds=Yn(e.seconds),e.minutes=Yn(e.minutes),e.hours=Yn(e.hours),e.months=Yn(e.months),e.years=Yn(e.years),this},jn.add=function(e,t){return Ae(this,e,t,1)},jn.subtract=function(e,t){return Ae(this,e,t,-1)},jn.as=function(e){if(!this.isValid())return NaN;var t,n,s=this._milliseconds;if("month"===(e=O(e))||"year"===e)return t=this._days+s/864e5,n=this._months+Ze(t),"month"===e?n:n/12;switch(t=this._days+Math.round(ze(this._months)),e){case"week":return t/7+s/6048e5;case"day":return t+s/864e5;case"hour":return 24*t+s/36e5;case"minute":return 1440*t+s/6e4;case"second":return 86400*t+s/1e3;case"millisecond":return Math.floor(864e5*t)+s;default:throw new Error("Unknown unit "+e)}},jn.asMilliseconds=On,jn.asSeconds=Tn,jn.asMinutes=xn,jn.asHours=bn,jn.asDays=Pn,jn.asWeeks=Wn,jn.asMonths=Hn,jn.asYears=Rn,jn.valueOf=function(){return this.isValid()?this._milliseconds+864e5*this._days+this._months%12*2592e6+31536e6*g(this._months/12):NaN},jn._bubble=function(){var e,t,n,s,i,r=this._milliseconds,a=this._days,o=this._months,u=this._data;return r>=0&&a>=0&&o>=0||r<=0&&a<=0&&o<=0||(r+=864e5*je(ze(o)+a),a=0,o=0),u.milliseconds=r%1e3,e=y(r/1e3),u.seconds=e%60,t=y(e/60),u.minutes=t%60,n=y(t/60),u.hours=n%24,a+=y(n/24),i=y(Ze(a)),o+=i,a-=je(ze(i)),s=y(o/12),o%=12,u.days=a,u.months=o,u.years=s,this},jn.clone=function(){return xe(this)},jn.get=function(e){return e=O(e),this.isValid()?this[e+"s"]():NaN},jn.milliseconds=Cn,jn.seconds=Fn,jn.minutes=Un,jn.hours=Ln,jn.days=Nn,jn.weeks=function(){return y(this.days()/7)},jn.months=Gn,jn.years=Vn,jn.humanize=function(e){if(!this.isValid())return this.localeData().invalidDate();var t=this.localeData(),n=function(e,t,n){var s=xe(e).abs(),i=En(s.as("s")),r=En(s.as("m")),a=En(s.as("h")),o=En(s.as("d")),u=En(s.as("M")),l=En(s.as("y")),d=i<=In.ss&&["s",i]||i<In.s&&["ss",i]||r<=1&&["m"]||r<In.m&&["mm",r]||a<=1&&["h"]||a<In.h&&["hh",a]||o<=1&&["d"]||o<In.d&&["dd",o]||u<=1&&["M"]||u<In.M&&["MM",u]||l<=1&&["y"]||["yy",l];return d[2]=t,d[3]=+e>0,d[4]=n,function(e,t,n,s,i){return i.relativeTime(t||1,!!n,e,s)}.apply(null,d)}(this,!e,t);return e&&(n=t.pastFuture(+this,n)),t.postformat(n)},jn.toISOString=Be,jn.toString=Be,jn.toJSON=Be,jn.locale=Ce,jn.localeData=Fe,jn.toIsoString=v("toIsoString() is deprecated. Please use toISOString() instead (notice the capitals)",Be),jn.lang=gn,P("X",0,0,"unix"),P("x",0,0,"valueOf"),C("x",Mt),C("X",/[+-]?\d+(\.\d{1,3})?/),L("X",function(e,t,n){n._d=new Date(1e3*parseFloat(e,10))}),L("x",function(e,t,n){n._d=new Date(g(e))}),e.version="2.20.1",function(e){Qe=e}(pe),e.fn=Dn,e.min=function(){return we("isBefore",[].slice.call(arguments,0))},e.max=function(){return we("isAfter",[].slice.call(arguments,0))},e.now=function(){return Date.now?Date.now():+new Date},e.utc=l,e.unix=function(e){return pe(1e3*e)},e.months=function(e,t){return Ee(e,t,"months")},e.isDate=r,e.locale=ae,e.invalid=c,e.duration=xe,e.isMoment=_,e.weekdays=function(e,t,n){return Ie(e,t,n,"weekdays")},e.parseZone=function(){return pe.apply(null,arguments).parseZone()},e.localeData=ue,e.isDuration=Me,e.monthsShort=function(e,t){return Ee(e,t,"monthsShort")},e.weekdaysMin=function(e,t,n){return Ie(e,t,n,"weekdaysMin")},e.defineLocale=oe,e.updateLocale=function(e,t){if(null!=t){var n,s,i=Qt;null!=(s=re(e))&&(i=s._config),(n=new k(t=D(i,t))).parentLocale=Xt[e],Xt[e]=n,ae(e)}else null!=Xt[e]&&(null!=Xt[e].parentLocale?Xt[e]=Xt[e].parentLocale:null!=Xt[e]&&delete Xt[e]);return Xt[e]},e.locales=function(){return nt(Xt)},e.weekdaysShort=function(e,t,n){return Ie(e,t,n,"weekdaysShort")},e.normalizeUnits=O,e.relativeTimeRounding=function(e){return void 0===e?En:"function"==typeof e&&(En=e,!0)},e.relativeTimeThreshold=function(e,t){return void 0!==In[e]&&(void 0===t?In[e]:(In[e]=t,"s"===e&&(In.ss=t-1),!0))},e.calendarFormat=function(e,t){var n=e.diff(t,"days",!0);return n<-6?"sameElse":n<-1?"lastWeek":n<0?"lastDay":n<1?"sameDay":n<2?"nextDay":n<7?"nextWeek":"sameElse"},e.prototype=Dn,e.HTML5_FMT={DATETIME_LOCAL:"YYYY-MM-DDTHH:mm",DATETIME_LOCAL_SECONDS:"YYYY-MM-DDTHH:mm:ss",DATETIME_LOCAL_MS:"YYYY-MM-DDTHH:mm:ss.SSS",DATE:"YYYY-MM-DD",TIME:"HH:mm",TIME_SECONDS:"HH:mm:ss",TIME_MS:"HH:mm:ss.SSS",WEEK:"YYYY-[W]WW",MONTH:"YYYY-MM"},e});
}

if (typeof buffer === "undefined") {
    buffer = window.buffer;
}
if (typeof pako === "undefined") {
    pako = window.pako;
}
if (typeof moment === "undefined") {
    moment = window.moment;
}

var vlocityPdfWriter = (function () {

	var SUPPORTED_PDF_VERSION = 1.5;
	
	var vPdfWriter = {};
	
	var _cachedBuffers = {};

	function getBuffer(stringVal)
	{
		if (_cachedBuffers[stringVal] == null)
		{
			_cachedBuffers[stringVal] = new buffer.Buffer(stringVal);
		}

		return _cachedBuffers[stringVal];
	}

	var CARRIAGE_RETURN = new buffer.Buffer([13]);
	var OBJECT_IDENTIFIER = new buffer.Buffer(' obj');
	var OBJECT_END_IDENTIFIER = new buffer.Buffer('endobj');
	var XREF_IDENTIFIER_LONG = new buffer.Buffer('startxref');
	var XREF_IDENTIFIER = new buffer.Buffer('xref');
	var XREF_STREAM_IDENTIFIER = new buffer.Buffer('/XRef/');
	var EOF_IDENTIFIER = new buffer.Buffer('%%EOF');
	var FLATE_IDENTIFIER = new buffer.Buffer('FlateDecode');
	var ANNOTATION_OBJECT_TOKEN = new buffer.Buffer('<</AP');
	var WIDGET_IDENTIFIER = new buffer.Buffer('Widget');
	var OPEN_STREAM_IDENTIFIER = new buffer.Buffer('stream');
	var ENDOBJ = new buffer.Buffer('endobj');
	var ENDSTREAM = new buffer.Buffer('endstream');
                                                             
	var FULL_CHAR_MAP = { 'A':'101', 'Æ':'306', 'Á':'301', 'Â':'302', 'Ä':'304', 'À':'300', 'Å':'305', 'Ã':'303', 'B':'102', 'C':'103', 'Ç':'307', 'D':'104', 'E':'105', 'É':'311', 'Ê':'312', 'Ë':'313', 'È':'310', 'Ð':'320', '€':'240', 'F':'106', 'G':'107', 'H':'110', 'I':'111', 'Í':'315', 'Î':'316', 'Ï':'317', 'Ì':'314', 'J':'112', 'K':'113', 'L':'114', 'Ł':'225', 'M':'115', 'N':'116', 'Ñ':'321', 'O':'117', 'OE':'226', 'Ó':'323', 'Ô':'324', 'Ö':'326', 'Ò':'322', 'Ø':'330', 'Õ':'325', 'P':'120', 'Q':'121', 'R':'122', 'S':'123', 'Š':'227', 'T':'124', 'Þ':'336', 'U':'125', 'Ú':'332', 'Û':'333', 'Ü':'334', 'Ù':'331', 'V':'126', 'W':'127', 'X':'130', 'Y':'131', 'Ý':'335', 'Ÿ':'230', 'Z':'132', 'Ž':'231', 'a':'141', 'á':'341', 'â':'342', '´':'264', 'ä':'344', 'æ':'346', 'à':'340', '&':'046', 'å':'345', '^':'136', '~':'176', '*':'052', '@':'100', 'ã':'343', 'b':'142', '\\':'134', '|':'174', '{':'173', '}':'175', '[':'133', ']':'135', '˘':'030', '¦':'246', '•':'200', 'c':'143', 'ˇ':'031', 'ç':'347', '¸':'270', '¢':'242', 'ˆ':'032', ':':'072', ',':'054', '©':'251', '¤':'244', 'd':'144', '†':'201', '‡':'202', '°':'260', '¨':'250', '÷':'367', '$':'044', '˙':'033', 'ı':'232', 'e':'145', 'é':'351', 'ê':'352', 'ë':'353', 'è':'350', '8':'070', '…':'203', '—':'204', '–':'205', '=':'075', 'ð':'360', '!':'041', '¡':'241', 'f':'146', 'fi':'223', '5':'065', 'fl':'224', 'ƒ':'206', '4':'064', '⁄':'207', 'g':'147', 'ß':'337', '`':'140', '>':'076', '«':'253', '»':'273', '‹':'210', '›':'211', 'h':'150', '˝':'034', '-':'055', 'i':'151', 'í':'355', 'î':'356', 'ï':'357', 'ì':'354', 'j':'152', 'k':'153', 'l':'154', '<':'74', '¬':'254', 'ł':'233', 'm':'155', '¯':'257', '−':'212', 'μ':'265', '×':'327', 'n':'156', '9':'071', 'ñ':'361', '#':'043', 'o':'157', 'ó':'363', 'ô':'364', 'ö':'366', 'oe':'234', '˛':'035', 'ò':'362', '1':'061', '½':'275', '¼':'274', '¹':'271', 'ª':'252', 'º':'272', 'ø':'370', 'õ':'365', 'p':'160', '¶':'266', '(':'050', ')':'051', '%':'045', '.':'056', '·':'267', '‰':'213', '+':'053', '±':'261', 'q':'161', '?':'077', '¿':'277', 'r':'162', '®':'256', '°':'036', 's':'163', 'š':'235', '§':'247', ';':'073', '7':'067', '6':'066', '/':'057', '':'040', '£':'243', 't':'164', 'þ':'376', '3':'063', '¾':'276', '³':'263', '˜':'037', '™':'222', '2':'062', '²':'262', 'u':'165', 'ú':'372', 'û':'373', 'ü':'374', 'ù':'371', '_':'137', 'v':'166', 'w':'167', 'x':'170', 'y':'171', 'ý':'375', 'ÿ':'377', '¥':'245', 'z':'172', 'ž':'236', '0':'060' };                                                                                                                                                                

	// Utility Methods
	function inflate(streamInfo)
	{
		return new buffer.Buffer(pako.inflate(new Uint8Array(streamInfo)));
	}

	function sameBuffer(buff1, buff2) {

	    if (buff1.length != buff2.length) return false;

	    for (var i = 0; i < buff1.length; i++) {
	        if (buff1[i] != buff2[i]) {
	            return false;
	        }
	    }

	    return true;
	}

	function indexOf(source, finding, startIndex) {

	    for (var i = startIndex != null ? startIndex : 0; i < source.length; i++) {

	        //console.log(source.length);

			if (finding instanceof Number)
		    {
		    	if (source[i] == finding)
		    	{
		    		return i;
		    	}
		    }
		    else if (finding instanceof String)
		    {
		    	if (String.fromCharCode(source[i]) == finding)
		    	{
		    		return i;
		    	}
		    }
			else if (finding instanceof Array) {
				
	            for (var f = 0; f < finding.length; f++) {
	                if (sameBuffer(finding[f], source.slice(i, i + finding[f].length))) {
	                    return i;
	                }
	            }
	        } else if (sameBuffer(finding, source.slice(i, i + finding.length))) {
	            return i;
	        }
	    }

	    return -1;
	}

	function previousIndexOf(source, finding, startIndex) {

	    for (var i = startIndex != null ? startIndex : 0; i >= 0; i--) {
	        if (finding instanceof Array) {
	            for (var f = 0; f < finding.length; f++) {
	                if (sameBuffer(finding[f], source.slice(i, i + finding[f].length))) {
	                    return i;
	                }
	            }
	        } else if (sameBuffer(finding, source.slice(i, i + finding.length))) {
	            return i;
	        }
	    }

	    return -1;
	}

	function firstIndexAfter(source, finding, startIndex) {

	    for (var i = startIndex != null ? startIndex : 0; i < source.length; i++) {
	        //console.log(source.length);
	        if (finding instanceof Array) {
	            for (var f = 0; f < finding.length; f++) {
	                if (sameBuffer(finding[f], source.slice(i, i + finding[f].length))) {
	                    return i + finding[f].length + 1;
	                }
	            }
	        } else if (sameBuffer(finding, source.slice(i, i + finding.length))) {
	            return i + finding.length + 1;
	        }
	    }
	}

	function extractBetween(buff, startString, endString, startingIndex) {
	    var sliceStart = firstIndexAfter(buff, startString, startingIndex)-1;
	    var sliceEnd = indexOf(buff, endString, sliceStart);

	    return buff.slice(sliceStart, sliceEnd+1);
	}

	function getLine(buff, currentIndex) {
	    var lineStart = Math.max(0, previousIndexOf(buff, [getBuffer("\n"), CARRIAGE_RETURN], currentIndex));

	    var endOfLine = indexOf(buff, [getBuffer("\n"), CARRIAGE_RETURN], currentIndex);

	    if (endOfLine == -1) {
	        endOfLine = buff.length;
	    }

	    while (lineStart < endOfLine && (buff[lineStart] == 10 || buff[lineStart] == 13)) // \n and \r
	    {
	    	lineStart++;
	    }

	    return buff.slice(lineStart, endOfLine);
	}

	function rectangleToBBox(rect)
	{
		var bbox = [0, 0, ];

		bbox.push(rect[2]-rect[0]);
		bbox.push(rect[3]-rect[1]);

		return bbox; 
	}

	function getPDFVersion(parentBuffer) {

		try {
			var version = getLine(parentBuffer, 0).toString('ascii');

			if (version == undefined) return 0;

	    	return parseFloat(version.replace("%PDF-", ""));
		}
		catch (err)
		{
			console.log(err);
			return 0;
		}
	}

	// PNG Up Predictor - https://forums.adobe.com/thread/664902 and http://www.w3.org/TR/PNG-Filters.html
	function pngUp(objectInfo) {
	    var retArray = [];

	    var max = 0;

	    for (var i = 0; i < objectInfo.length; i++) {
	       max = Math.max(objectInfo[i].index, max);
	    }

	    var hexLength = Math.floor((max.toString(16).length + 1) / 2);

	    // First and Last values are always short, middle values are split hex string value of byte indecies of objects in pdf
	    var previousRow = [];

	    while (previousRow.length < hexLength + 2)
	    {
	    	 previousRow.push(0);
	    }
	    //console.log(previousRow);

	    for (var i = 0; i < objectInfo.length; i++) {

	        var asHex = (objectInfo[i].index).toString(16);

	        // Need to pad hex string with 0's
	        while (asHex.length < hexLength * 2) {
	            asHex = '0' + asHex;
	        }

	       //console.log(asHex);

	        var thisRow = [];
	        var nextPreviousRow = [];

	        // 0 is always type
	        thisRow.push(objectInfo[i].type - Math.abs(previousRow[0]));
	        nextPreviousRow.push(objectInfo[i].type);

	        var rowIndex = 1;

	        // The middle two variables are the index converted to hex then split into the columns
	        for (; rowIndex < hexLength+1; rowIndex++)
	        {
	        	var hexIndex = rowIndex*2;
	        	var hexIndex = parseInt(asHex.substring(hexIndex-2, hexIndex), 16);

	        	thisRow.push(hexIndex - Math.abs(previousRow[rowIndex]));
	        	nextPreviousRow.push(hexIndex);
	        }

	        previousRow = nextPreviousRow;

	        retArray.push(2); // Always first in PNG UP
	        retArray = retArray.concat(thisRow);
	    }

	    //console.log(retArray);

	    return { retArray: retArray, wLength: hexLength };
	}

	// Any keys that are added programatically should their separator listed here
	var seperatorTypesToKeys = {
		" ": ["Length", "Parent", "Root", "First", "Columns", "N", "Predictor", "Prev", "Size", "FormType", "P", "Ff"],
	    "/": ["Filter", "Type", "Subtype", "FT"],
	    "[": ["BBox", "W", "Rect", "Index", "Kids", "BC", "BG"],
	    "(": ["T", "V", "DA"],
	    "<": ["DecodeParms", "AP", "MK", "Resources", "Font"]
	}

	var nonHeirarchicalProperties = ["Type", "Subtype", "Parent"];

	function getSeperatorForKey(key)
	{
		for (var type in seperatorTypesToKeys)
		{
			if (seperatorTypesToKeys.hasOwnProperty(type))
			{
				if (seperatorTypesToKeys[type].indexOf(key) != -1)
				{
					return type;
				}
			}
		}

		return null;
	}

	function copyProperty(obj1, obj2, key)
	{
		if (obj2.propertyDictionary[key] != null)
		{
			obj1.propertyDictionary[key] = obj2.propertyDictionary[key];
		}
	}

	function PdfDictEntry(key, value, sep)
	{
		if (value instanceof PdfDictEntry)
		{
			this.key = key;
			this.value = value.value;
			this.seperatorChar = value.seperatorChar;
		}
		else
		{
			this.key = key;
			this.seperatorChar = sep;

			if (this.seperatorChar == "[")
			{
				if (Array.isArray(value))
				{
					this.value = value; 
				}
				else
				{
					this.value = value.substring(1, value.length-1).split(" ");
				}
			}
			else if (this.seperatorChar == "(")
			{
				if (value[0] == "(" && value[value.length-1] == ")")
				{
					this.value = value.substring(1, value.length-1);
				}
				else
				{
					this.value = value;
				}
			}
			else
			{
				this.value = value;
			}
		}
	}

	PdfDictEntry.prototype = {
		constructor: PdfDictEntry,

		getKey: function(atIndex, values)
		{
			if (this.seperatorChar == "<")
			{
				var currentKey = values[atIndex];

				if (currentKey == null) return this.value;

				if (this.value[currentKey] instanceof PdfDictEntry)
				{
					return this.value[currentKey].getKey(++atIndex, values);
				}

				if (this.value[currentKey] == null) return null;
	
				return this.value[currentKey].getKey(currentKey);
			}

			return this.value;
		},

		toStringPdf: function()
		{
			if (this.seperatorChar == "[")
			{
				if (this.value instanceof Array)
				{
					return this.key + "[" + this.value.join(" ") + "]"; 
				}

				return this.key + this.value; 
			}
			else if (this.seperatorChar == "(")
			{
				return this.key + "(" + this.value + ")"; 
			}
			else if (this.seperatorChar == "/")
			{
				return this.key + "/" + this.value; 
			}
			else if (this.seperatorChar == "<")
			{
				var fullString = "<<"; 

				if (this.value != null)
				{
					var propertyArray = Object.keys(this.value);

					for (var i = 0; i < propertyArray.length; i++)
					{	
						if (this.value[propertyArray[i]] != null)
						{
							fullString += "/";
							fullString += this.value[propertyArray[i]].toStringPdf();
						}
					}
				}

				return this.key + fullString + ">>";
			}
			else if (this.seperatorChar == " ")
			{
				return this.key + " " + this.value; 
			}
			else if (this.value instanceof Object)
			{
				var propertyArray = Object.keys(this.value);

				var fullString = this.key + "<<"; 

				for (var i = 0; i < propertyArray.length; i++)
				{	
					if (this.value[propertyArray[i]] != null)
					{
						fullString += "/";
						var pdfDictTemp = new PdfDictEntry(propertyArray[i], this.value[propertyArray[i]], getSeperatorForKey(propertyArray[i]));
						fullString += pdfDictTemp.toStringPdf();						
					}
				}


				return fullString + ">>";
			}

			return this.key + " " + this.value; 
		}
	}

	function getObjectsFromStream(firstObjectIndex, streamData) {
	  	
	  	firstObjectIndex = parseInt(firstObjectIndex);
	    var objectIdBuffer = streamData.slice(0, firstObjectIndex - 1);
	    var objectIdsAndIndex = objectIdBuffer.toString('utf8').split(' ');

	    var objectsInStream = [];

	    for (var i = 0; i < objectIdsAndIndex.length; i = i + 2) 
	    {
	    	var objectId = parseInt(objectIdsAndIndex[i]);
	    	var startOfObject = parseInt(objectIdsAndIndex[i + 1]) + firstObjectIndex;

	        var endOfObject;
	        if (i == objectIdsAndIndex.length - 2) {
	            endOfObject = streamData.length;
	        } else {
	            endOfObject = parseInt(objectIdsAndIndex[i + 3]) + firstObjectIndex - 1;
	        }
	 
	        objectsInStream.push(new StreamObject(objectId, streamData.slice(startOfObject, endOfObject)));
	    }
	    
	    return objectsInStream;
	}


	function escapeChar(char)
	{
		if (FULL_CHAR_MAP[char])
		{
			return '\\' + FULL_CHAR_MAP[char];
		}
		else
		{
			return char;
		}
	}

	function escapeTextForTextField(text)
	{	
		var pdfEncodedText = '';

		for (var i = 0; i < text.length; i++)
		{
			pdfEncodedText += escapeChar(text[i]);
		}
        
		return pdfEncodedText;
	}

	// Default Text Creation for a Field
	function getDefaultFieldText(fontInfo, bbox, text)
	{
		var bboxHeight = bbox[3]-bbox[1];

		var heightOffset = bboxHeight * .25;

		return "/Tx BMC \nBT\n" + fontInfo + "\n2 " + heightOffset + " Td\n(" + escapeTextForTextField(text) + ") Tj\nET\nEMC";
	}

	function TextObject(text)
	{
		// Example
		// "/Tx BMC \nBT\n0 0 0 rg /F3 11 Tf\n0 g\n2 2.106 Td\n(zzzzzzzzzz) Tj\nET\nEMC\n"

		this.properties = {};
		this.rawText = text;
		var textArray = text.split("\n");

		for (var i = 0; i < textArray.length; i++)
		{
			var textLineArray = textArray[i].split(" ");

			var key = textLineArray[textLineArray.length-1];

			this.properties[key] = textArray[i];
		}
	}

	TextObject.prototype = {
		constructor: TextObject,

		getProperty: function(property)
	    {
	    	return this.properties[key];
	    },

	    // TABLE 3.2 Escape sequences in literal strings
		// Need to Additionally Escape (, ), \

		replaceText: function(newText)
		{
			var openTextIndex;
			var closedTextIndex;

			for (var i = 1; i < this.rawText.length; i++)
			{
				if (this.rawText[i-1] != "\\")
				{
					if (this.rawText[i] == "(" && openTextIndex == null)
					{
						openTextIndex = i;
					}
					else if (this.rawText[i] == ")" && closedTextIndex == null)
					{
						closedTextIndex = i;
					}
				}
			}

			return this.rawText.substring(0, openTextIndex+1) + escapeTextForTextField(newText) + this.rawText.substring(closedTextIndex, this.rawText.length-1);
		}
	}

	function PdfObject(fullObject, indexOfObject) {

	    this.Id = getLine(fullObject, 0).toString();
	    this.indexOfObject = indexOfObject;

	    this.objectIdInt;
	    this.streamData = [];

	    if (this.Id.indexOf('obj') != -1)
	    {
			this.objectIdInt = this.Id.split(" ")[0];
	    }

	    var objectInfoEndIndex = indexOf(fullObject, [ OPEN_STREAM_IDENTIFIER, OBJECT_END_IDENTIFIER, XREF_IDENTIFIER ]);
		
		this.propertyDictionary = parseObjectData(fullObject.slice(0, objectInfoEndIndex)).obj;

	    var streamStart = firstIndexAfter(fullObject, [ OPEN_STREAM_IDENTIFIER ]);
		
		if (streamStart != -1)
		{
			while (fullObject[streamStart] == 13 || fullObject[streamStart] == 10) { // \n || \r
				streamStart++;
	        }

			var streamEnder = indexOf(fullObject, ENDSTREAM);

			if (this.getProperty("Filter") == "FlateDecode" || (Array.isArray(this.getProperty("Filter")) && this.getProperty("Filter")[0] == "/FlateDecode"))
			{
				var inflated = inflate(fullObject.slice(streamStart, streamEnder));

				if (this.getProperty("Type") == "ObjStm")
				{
					this.streamData = getObjectsFromStream(this.getProperty("First"), inflated);
				}
				else if (this.getProperty("Type") == "XRef")
				{
					// Not sure I care
					getXRefStreamInfo(this, inflated);
				}
				else
				{
					var streamBlob = inflated.toString('ascii');

					if (streamBlob.indexOf("BT") > -1)
					{
						this.textObject = new TextObject(streamBlob);
					}
				}
			}
			else
			{
				var streamBlob = fullObject.slice(streamStart, streamEnder).toString('ascii');

				if (streamBlob.indexOf("BT") > -1 && streamBlob.indexOf("ET") > -1 )
				{
					this.textObject = new TextObject(streamBlob);
				}
			}

		}
	}


	PdfObject.prototype = {
		constructor: PdfObject,

		getProperty: function(property, key)
	    {
	    	if (this.propertyDictionary[arguments[0]] == null) return null;

			return this.propertyDictionary[arguments[0]].getKey(1, arguments);
	    },

	    getPropertyKeys: function()
	    {
	    	return Object.keys(this.propertyDictionary);
	    },

	    getReferenceId: function()
	    {
	    	return this.objectIdInt + " 0 R";
	    },

		toStringPdf: function()
		{
			var ret = this.Id;

			ret += "\n<<";

			var propertyArray = Object.keys(this.propertyDictionary);

			for (var i = 0; i < propertyArray.length; i++)
			{
				if ( this.propertyDictionary[propertyArray[i]] != null)
				{
					ret += "/";
					ret += this.propertyDictionary[propertyArray[i]].toStringPdf();
				}
			}

			ret += ">>";

			ret += "stream\n";
			if (this.streamData)
			{
				for (var i = 0; i < this.streamData.length; i++)
				{
					ret += this.streamData[i].toStringPdf();
				}
				
			}

			if (this.textObject != null)
			{
				ret += this.textObject.rawText + "\n";
			}

			ret += "endstream";
			ret += "\nendobj\n";
			
			return ret;	
		}
	}

	function StreamObject(id, objectdata)
	{
		this.Id = id;
		this.propertyDictionary = parseObjectData(objectdata).obj;
	}

	StreamObject.prototype = new Object();
	StreamObject.prototype.constructor = StreamObject;

	StreamObject.prototype.getProperty = function()
	{
		if (this.propertyDictionary[arguments[0]] == null) return null;

		return this.propertyDictionary[arguments[0]].getKey(1, arguments);
	}

	StreamObject.prototype.getPropertyKeys = function()
    {
    	return Object.keys(this.propertyDictionary);
    }

    StreamObject.prototype.getReferenceId = function()
    {
    	return this.Id + " 0 R";
    }

	StreamObject.prototype.toStringPdf = function()
    {
    	var ret = "Stream " + this.Id;

		ret += " <<";

		var propertyArray = Object.keys(this.propertyDictionary);

		for (var i = 0; i < propertyArray.length; i++)
		{
			if (this.propertyDictionary[propertyArray[i]] != null)
			{
				ret += "/";
				ret += this.propertyDictionary[propertyArray[i]].toStringPdf();
			}
		}

		ret += ">>\n";

		return ret;

    }

	function addProperty(obj, key, value, sep)
	{
		if (sep == null)
		{
			sep = getSeperatorForKey(key);
		}

		obj[key] = new PdfDictEntry(key, value, sep);
	}

	function PdfWriteStreamBlob(textBlob)
	{
		this.blob = textBlob;
	}

	function PdfWriteStreamObject(copyObject)
	{
		this.Id = copyObject.Id;
		this.propertyDictionary = copyObject.propertyDictionary;
	}

	PdfWriteStreamObject.prototype = new Object();
	
	PdfWriteStreamObject.prototype.constructor = PdfWriteStreamObject;

	PdfWriteStreamObject.prototype.addProperty = function(key, value, sep)
	{
		if (value instanceof Object && !(value instanceof Array))
		{
			addProperty(this.propertyDictionary, key, parseObjectData(value).obj, sep);
		}
		else
		{
			addProperty(this.propertyDictionary, key, value, sep);
		}
	}

	PdfWriteStreamObject.prototype.removeProperty = function(key)
	{
		delete this.propertyDictionary[key];
	}

	PdfWriteStreamObject.prototype.getProperty = function(property, key)
	{
		if (this.propertyDictionary[arguments[0]] == null) return null;

		return this.propertyDictionary[arguments[0]].getKey(1, arguments);
	}

	PdfWriteStreamObject.prototype.toPdfBuffer = function()
	{
		var bufferArray = [new buffer.Buffer("<<")];

		var propertyArray = Object.keys(this.propertyDictionary);

		for (var i = 0; i < propertyArray.length; i++)
		{
			if (this.propertyDictionary[propertyArray[i]] != null)
			{
				bufferArray.push(new buffer.Buffer("/"));
				bufferArray.push(new buffer.Buffer(this.propertyDictionary[propertyArray[i]].toStringPdf()));
			}
		}

		bufferArray.push(new buffer.Buffer(">>"));

		return buffer.Buffer.concat(bufferArray);
	}

	function PdfWriteObject(id)
	{
		this.Id = id;
		this.propertyDictionary = {};
		this.stream = [];
		this.XRefObjectIds = [];
		this.asBuffer;
	}

	PdfWriteObject.prototype = new Object();
	
	PdfWriteObject.prototype.constructor = PdfWriteObject;

	PdfWriteObject.prototype.idObjString = function()
	{
		return this.Id + " 0 obj";
	}

	PdfWriteObject.prototype.addProperty =function(key, value)
	{
		if (value instanceof Object && !(value instanceof Array))
		{
			addProperty(this.propertyDictionary, key, parseObjectData(value).obj);
		}
		else
		{
			addProperty(this.propertyDictionary, key, value);
		}
	}

  	PdfWriteObject.prototype.getProperty = function(property, key)
    {
    	if (this.propertyDictionary[arguments[0]] == null) return null;

		return this.propertyDictionary[arguments[0]].getKey(1, arguments);
    }

	PdfWriteObject.prototype.addToStream = function(obj)
	{
		this.stream.push(obj);
	}

	PdfWriteObject.prototype.getXRefIds = function()
	{
		var xrefIds = [];

		for (var i = 0; i < this.stream.length; i++)
		{
			if (this.stream[i].Id != null)
			{
				// Parent or steam?
				xrefIds.push({type: 2, Id: this.Id, indexId: this.stream[i].Id });
			}
		}

		xrefIds.push({type: 1, Id: this.Id, indexId: this.Id });

		return xrefIds;
	}

	// Only supporting 1 object per stream for now.
	PdfWriteObject.prototype.getStreamBuffer = function()
	{
		if (this.stream.length != 0)
		{
			var streamObjectArray = 0;
			var streamData;

			if (this.stream[0].Id != null)
			{
				streamObjectArray = this.stream[0].Id + " 0 ";
				this.addProperty("First", streamObjectArray.length);
			}

			if (this.getProperty("Filter") != null)
			{
				var buffersToDeflateArray = [];

				if (this.getProperty("Type") == "ObjStm")
				{
					buffersToDeflateArray.push(new buffer.Buffer(streamObjectArray));
				}

				if (this.stream[0] instanceof PdfWriteStreamObject)
				{
					buffersToDeflateArray.push(this.stream[0].toPdfBuffer());
				}
				else
				{
					buffersToDeflateArray.push(this.stream[0]);
				}

				streamData = new buffer.Buffer(pako.deflate(new Uint8Array(buffer.Buffer.concat(buffersToDeflateArray))));
			}
			else
			{
				if (this.stream[0] instanceof PdfWriteStreamBlob)
				{
					streamData = new buffer.Buffer(this.stream[0].blob);
				}
				else
				{
					streamData = this.stream[0].toPdfBuffer();
				}
			}

			this.addProperty("Length", streamData.length);

			return streamData;
		}

		return null;
	}

	PdfWriteObject.prototype.toPdfBuffer = function()
	{
		if (this.asBuffer == null)
		{
			var bufferArray = [new buffer.Buffer(this.idObjString() + "\n<<")];
			var streamBuffer = this.getStreamBuffer();

			var propertyArray = Object.keys(this.propertyDictionary);

			for (var i = 0; i < propertyArray.length; i++)
			{
				if (this.propertyDictionary[propertyArray[i]] != null)
				{
					bufferArray.push(new buffer.Buffer("/"));
					bufferArray.push(new buffer.Buffer(this.propertyDictionary[propertyArray[i]].toStringPdf()));
				}
			}

			bufferArray.push(new buffer.Buffer(">>"));

			if (streamBuffer != null)
			{
				bufferArray.push(new buffer.Buffer("stream\n"));
				bufferArray.push(streamBuffer);
				bufferArray.push(new buffer.Buffer("\nendstream"));
			}

			bufferArray.push(new buffer.Buffer("\nendobj\n"));

			this.asBuffer = buffer.Buffer.concat(bufferArray);
		}

		return this.asBuffer;
	}

	function parseObjectData(objData)
	{
		var parsedObject = {};
		var finalIndex = 0;

		if (buffer.Buffer.isBuffer(objData))
		{
			var keyString;
			var valueObj;
			var seperatorChar;

			var openObject = false;

			while (finalIndex < objData.length)
			{
				var curChar = String.fromCharCode(objData[finalIndex]);
	
				if (keyString == null)
				{
					if (curChar == "<" || curChar == "/")
					{
						// DO NOTHING
						openObject = true;
					}
					else if (curChar == ">")
					{
						break;
					}
					else if (openObject)
					{
						keyString = curChar;
					}
				}
				else if (valueObj == null)
				{
					if (curChar == "<")
					{
						var parseReturn = parseObjectData(objData.slice(finalIndex));

						addProperty(parsedObject, keyString, parseReturn.obj, curChar);

						finalIndex += parseReturn.finalIndex + 1;

						keyString = null;
						valueObj = null;
						seperatorChar = null;
					}
					else if (curChar == "/" || curChar == " " || curChar == "[" || curChar == "(")
					{
						valueObj = "";

						if (curChar == "[" || curChar == "(")
						{
							valueObj += curChar;
						}

						seperatorChar = curChar;
					}
					else
					{
						keyString += curChar;
					}
				}
				else 
				{
					if (seperatorChar != "[" && seperatorChar != "(" && curChar == ">")
					{
						addProperty(parsedObject, keyString, valueObj, seperatorChar);

						break; 
					}
					else if ((seperatorChar == "[" && curChar == "]") 
						|| (seperatorChar == "(" && curChar == ")")
						|| ((seperatorChar == " " || seperatorChar == "/") && (curChar == "/")))
					{
						if (curChar == "]" || curChar == ")")
						{
							valueObj += curChar;
						}

						addProperty(parsedObject, keyString, valueObj, seperatorChar);

						keyString = null;
						valueObj = null;
						seperatorChar = null;
					}
					else
					{
						valueObj += curChar;
					}
				}

				finalIndex++;
			}
		}
		else if (objData instanceof Object)
		{
			Object.keys(objData).forEach(function (key) {
				addProperty(parsedObject, key, objData[key]);
			});	
		}

		return { obj: parsedObject, finalIndex: finalIndex };
	}

	function getXRefStreamInfo(header, xrefStream) {

	    var WArray = header.getProperty("W");

	    var bufferForXref = [];

	    var xrefObjs = [];

	    var types = [];
	    var offsets = '';
	    var row = 0;

	    var TColumns = parseInt(header.getProperty("DecodeParms", "Columns"))+1;

	    var splitBytesToColumns = [new Array(TColumns)];

	    for (var i = 0; i < xrefStream.length; i++) {
	        var row = Math.floor(i / TColumns);

	        var column = i % TColumns;

	        if (xrefObjs.length <= row) {
	            xrefObjs.push({
	                hex: ''
	            });
	        }

	        var currentByte = xrefStream[i];

	        if (column == 0) {
	            xrefObjs[row]['predictor'] = currentByte;
	            continue;
	        }

	        if (splitBytesToColumns.length <= row) {
	            splitBytesToColumns.push(new Array(TColumns));
	        }

	        var additionToBit = 0;

	        if (row != 0) {
	            additionToBit = splitBytesToColumns[row - 1][column];
	        }

	        var unpredicted = Math.abs(currentByte + additionToBit) % 256;

	        splitBytesToColumns[row][column] = unpredicted;

	        if (column <= parseInt(WArray[0])) {
	            xrefObjs[row]['type'] = unpredicted;
	        }
	        else if (column <= parseInt(WArray[0]) + parseInt(WArray[1])) {
	            xrefObjs[row]['hex'] += unpredicted.toString(16);
	        }
	        else 
	        {
	            xrefObjs[row]['flag'] = unpredicted;
	        }
	    }
	}

	function PdfDocument(fileBuffer)
	{
		this.pdfData = fileBuffer;

		this.allObjects = [];

		this.newObjectsToWrite = [];

		this.refreshObjectIndices();

		this.alreadyAddedParents = [];

		this.cachedObjectsById = {};

		this.cachedFontsByName = {};
		
		for (var index =  0; index < this.objectIndices.length; index++)
		{
			var pdfObject = this.objectIndices[index];

			// Get PDF Object or Chunk
			var currentBuffer = this.pdfData.slice(pdfObject.startObj, pdfObject.endObj);

			this.allObjects.push(new PdfObject(currentBuffer, pdfObject.startObj));
		}

		this.totalObjects = this.getHighestObjectId()+10; 
	}

	PdfDocument.prototype = {
		constructor: PdfDocument,

		refreshObjectIndices: function() {

		    this.objectIndices = [];
		    this.objectIndexMap = {};

		    var objStartIndex = 0;
		    var objectEndIndex = 0;

		    while (objStartIndex != -1) {
		        objStartIndex = indexOf(this.pdfData, [ XREF_IDENTIFIER, OBJECT_IDENTIFIER, XREF_IDENTIFIER_LONG ], objectEndIndex);

		        if (objStartIndex != -1) {
		            var lineBeginning = previousIndexOf(this.pdfData, [ getBuffer("\n"), CARRIAGE_RETURN ], objStartIndex) + 1;

		            objectEndIndex = indexOf(this.pdfData, [ OBJECT_END_IDENTIFIER, EOF_IDENTIFIER ], objStartIndex);

		            this.objectIndices.push({
		                startObj: lineBeginning,
		                endObj: objectEndIndex
		            });

		            var objectId = getLine(this.pdfData, lineBeginning).toString();

		           this.objectIndexMap[objectId] = lineBeginning;
		        }
		    }

		    //console.log(this.objectIndices);

		    return this.objectIndices;
		},

		// Not Sure if this is always true, but is for all linearized that I have seen
		getLinearXRefStreamIndex: function()
		{
			return this.allObjects[1].indexOfObject;
		},

		getRootId: function()
		{
			var rootObject = this.getMatchingObjects( { Type: "Catalog" } );
			
			//console.log(rootObject);

			if (rootObject.length == 1)
			{
				return rootObject[0].getReferenceId();
			}
		},

		// Get Property accounting for possible Parent / Kids Heirarchical Format
		getPropertyFromObject: function(obj, propertyKey, innerKey)
		{
			if (nonHeirarchicalProperties.indexOf(propertyKey) != -1)
			{
				return obj.getProperty(propertyKey, innerKey); 
			}
			else if (obj.getProperty("Parent") == null)
			{
				return obj.getProperty(propertyKey, innerKey);
			}
			else
			{
				var parentObj = this.getObjectById(obj.getProperty("Parent", innerKey));

				if (parentObj == null)
				{
					return null;
				}

				var parentData = this.getPropertyFromObject(parentObj, propertyKey, innerKey);

				if (parentData == null)
				{
					return obj.getProperty(propertyKey, innerKey);
				}
				else
				{
					if (obj.getProperty(propertyKey, innerKey) != null)
					{
						return this.getPropertyFromObject(parentObj, propertyKey, innerKey) + '.' + obj.getProperty(propertyKey, innerKey);
					}

					return this.getPropertyFromObject(parentObj, propertyKey, innerKey); 
				}

			}
		},

		// Get Objects that match criteria in objectMap Object from objectList. Null objectList gets from Parent PdfDoc 
		getMatchingObjects: function(objectMatch, objectList)
		{
			var matchingObjects = [];

			if (objectList == null)
			{
				objectList = this.allObjects;
			}
		
			var matchingKeys = Object.keys(objectMatch);

			for (var i = 0; i < objectList.length; i++)
			{
				var obj = objectList[i];

				var matches = true;

			//	console.log("Obj " + obj.Id);
			
				for (var j = 0; j < matchingKeys.length; j++)
				{
					var withParent = this.getPropertyFromObject(obj, matchingKeys[j]);
					
					if (withParent == null)
					{

					//	console.log("key: " +  matchingKeys[j] + " -- withParent: " + withParent + " looking for: " + objectMatch[matchingKeys[j]]);
						matches = false;
						break;
					}
					else if (objectMatch[matchingKeys[j]] != "ALL" && withParent != objectMatch[matchingKeys[j]])
					{
						matches = false;
						break;
					}
				}

				if (matches)
				{
					matchingObjects.push(obj);
				}

				if (obj.streamData != null && obj.streamData.length > 0)
				{
					matchingObjects = matchingObjects.concat(this.getMatchingObjects(objectMatch, obj.streamData));
				}
			}

			return matchingObjects;
		},

		writeNewObject: function(newObject)
		{
			this.pdfData = buffer.Buffer.concat([this.pdfData, new buffer.Buffer("\n"), newObject.toPdfBuffer() ]);
			this.newObjectsToWrite.push(newObject);
		},

		writeNewXrefStream: function()
		{
			var xRefBytePosition = this.pdfData.length + 1;

			this.refreshObjectIndices();

			var xrefObjects = [];
			var xrefIndexForStream = [];

			for (var i = 0; i < this.newObjectsToWrite.length; i++)
			{
				var xrefInfo = this.newObjectsToWrite[i].getXRefIds();

				//console.log(xrefInfo);

				for (var j = 0; j < xrefInfo.length; j++)
				{
					xrefIndexForStream.push(xrefInfo[j].indexId);
					xrefIndexForStream.push(1);

					var xrefObj = { type: xrefInfo[j].type };

					if (xrefInfo[j].type == 1)
					{
						xrefObj["index"] = this.objectIndexMap[xrefInfo[j].Id + " 0 obj"];
					}
					else if (xrefInfo[j].type == 2)
					{
						// Should I be sending the parent Id or the Child stream Id?
						xrefObj["index"] = xrefInfo[j].Id;
					}

					xrefObjects.push(xrefObj);
				}
			}
			var xrefWriteObject = new PdfWriteObject(this.getNextObjectId());

			xrefObjects.push({ type: 1, index: xRefBytePosition });
			xrefIndexForStream.push(xrefWriteObject.Id);
			xrefIndexForStream.push(1);

			var pngUpResult = pngUp(xrefObjects);
			var xrefBody = pngUpResult.retArray;
			xrefWriteObject.addProperty("W", "[1 " + pngUpResult.wLength + " 0]"); // Always using 1 X 0 when building XRef Stream 

			xrefWriteObject.addProperty("Type","XRef");
			xrefWriteObject.addProperty("Filter", "FlateDecode");

			xrefWriteObject.addProperty("Index", "[" + xrefIndexForStream.join(" ") + "]"); 
			xrefWriteObject.addProperty("DecodeParms", { Columns: pngUpResult.wLength+1, Predictor: 12 } ); 
			xrefWriteObject.addProperty("Prev", this.getLinearXRefStreamIndex()); 
			xrefWriteObject.addProperty("Size", this.getNextObjectId()); 
			xrefWriteObject.addProperty("Root", this.getRootId());

			xrefWriteObject.addToStream(xrefBody);

			this.writeNewObject(xrefWriteObject);

			this.pdfData = buffer.Buffer.concat([this.pdfData, new buffer.Buffer("startxref\n"+xRefBytePosition+"\n%%EOF\n") ]);
		
		},

		getHighestObjectId: function()
		{
			var max = 0;

			for (var i = 0; i < this.allObjects.length; i++)
			{
				var parsed = parseInt(this.allObjects[i].Id);

				max = Math.max(max, isNaN(parsed) ?  0 : parsed );

				if (this.allObjects[i].streamData != null && this.allObjects[i].streamData.length > 0)
				{
					for (var j = 0; j <  this.allObjects[i].streamData.length; j++)
					{
						var parsedStream = parseInt(this.allObjects[i].streamData[j].Id);

						max = Math.max(max, isNaN(parsed) ? 0 : parsedStream);
					}
				}
			}

			return max;
		},

		getNextObjectId: function()
		{
			return this.totalObjects++;
		},

		getFontFieldReference: function(fontInfo)
		{
			if (this.cachedFontsByName[fontInfo] == null)
			{
				// Find Font by Name/FontName --> Not sure about multiple fonts with same name.
				var obj = this.getMatchingObjects( { Name : fontInfo } );

				if (obj.length == 0)
				{
					this.cachedFontsByName[fontInfo] = "";
				}
				else
				{
					this.cachedFontsByName[fontInfo] = obj[0].getReferenceId();
				}
			}

			return this.cachedFontsByName[fontInfo];

		},

		fillField: function(fieldObject, fillData, options)
		{
			if (fillData == "true") fillData = "Yes";

			if (fillData == "false") fillData = "No";

			var writeObjects = [];

			// Create Copy of Stream Onbject for Field with new appearence object and new text in V
			var fieldObjectInStream = new PdfWriteStreamObject(fieldObject);
			var newParent;
			var appearenceObject;

			var currentFieldFlags = this.getPropertyFromObject(fieldObjectInStream, "Ff");
			if (options != null && options.readOnly) 
            {
                if (currentFieldFlags == null) 
                {
                    fieldObjectInStream.addProperty("Ff", "1");
                } 
                else 
                {
                    currentFieldFlags = parseInt(currentFieldFlags) + 1;
                    fieldObjectInStream.addProperty("Ff", currentFieldFlags);
                }
            }

			
			var fieldType = this.getPropertyFromObject(fieldObject, "FT");

			if (fieldType == "Tx" || fieldType == "Ch")
			{
				// Referenced by Form Field In Stream
				appearenceObject = new PdfWriteObject(this.getNextObjectId());

				// Create Text for Appearance Stream
				var fontInfo = this.getPropertyFromObject(fieldObject, "DA");

				var appearanceParentId = this.getPropertyFromObject(fieldObject, "AP", "N");

				var defaultResources = this.getPropertyFromObject(fieldObject, "DR");

				var parentApp = this.getObjectById(appearanceParentId);
				
				var text;

				var boundingBox = rectangleToBBox(fieldObject.getProperty("Rect"));

				if (parentApp != null && parentApp.textObject != null)
				{
                    if (fillData)
                    {
                        text = parentApp.textObject.replaceText(fillData);
                    } 
                    else 
                    {
                        text = '';
                    }
					
					copyProperty(appearenceObject, parentApp, "Resources");
				}
				else
				{
                    if (fillData)
                    {
                        text = getDefaultFieldText(fontInfo, boundingBox, fillData);
                    }
                    else
                    {
                        text = '';
                    }

	 				if (defaultResources != null)
	 				{
	 					appearenceObject.addProperty("Resources", defaultResources);
	 				}
	 				else if (fillData)
	 				{
	 					if ( fontInfo == null)
	 					{
	 						throw 'No Font Settings Found in PDF'; 
	 					}

		 				var fontName = fontInfo.slice(1, fontInfo.indexOf(" "));

		 				var fontReference = this.getFontFieldReference(fontName);

		 				if (fontReference != "")
		 				{
			 				var fontObject = {};

			 				fontObject[fontName] = fontReference;
			 				appearenceObject.addProperty("Resources", { "Font": new PdfDictEntry("Font", fontObject) });
		 				}
	 				}
				}

				appearenceObject.addToStream(new PdfWriteStreamBlob(text));

				// Add Relevant properties to Appearence Object
				appearenceObject.addProperty("BBox", boundingBox);
				appearenceObject.addProperty("Type", "XObject");
				appearenceObject.addProperty("Subtype", "Form");
				appearenceObject.addProperty("FormType", "1");

				writeObjects.push(appearenceObject);

				fieldObjectInStream.addProperty("AP", { "N": appearenceObject.Id + " 0 R" });				
			}
            
			//console.log(JSON.stringify(appearenceObject, null, 2));
			if (fieldObject.getProperty("Parent") != null)
			{
				var parentObj = this.getObjectById(fieldObject.getProperty("Parent"));

				newParent = new PdfWriteStreamObject(parentObj);

				if (parentObj instanceof StreamObject && this.alreadyAddedParents.indexOf(parentObj.Id) == -1)
				{
					// Create Copy of Stream Onbject for Field with new appearence object and new text in V
					var newParentformXObject = new PdfWriteObject(this.getNextObjectId());
					newParentformXObject.addProperty("Type","ObjStm");
					newParentformXObject.addProperty("Filter", "FlateDecode");
					newParentformXObject.addProperty("N", "1");

					newParentformXObject.addToStream(newParent);

					writeObjects.push(newParentformXObject);

					this.alreadyAddedParents.push(parentObj.Id);
				}
			}

			if (fieldType == "Ch")
			{
				// Might not be the best way, but this I is optional and easier this than parse for now
				fieldObjectInStream.removeProperty("I");				
			}

            if (fillData)
            {
				if (fieldObject.getProperty("T") == null && newParent != null)
				{
					if (fieldType == "Btn")
					{
						newParent.addProperty("V", fillData, "/");

						if (newParent.getProperty("AS") != null)
						{
							newParent.addProperty("AS", fillData, "/");
						}
						else if (fieldObjectInStream.getProperty("AS") != null && fieldObjectInStream.getProperty("AP", "D", fillData) != null)
						{ 
							fieldObjectInStream.addProperty("AS", fillData, "/");
						}
					}
					else
					{
						newParent.addProperty("V", escapeTextForTextField(fillData));
					}
				}
				else if (fieldObject.getProperty("T") != null)
				{
					if (fieldType == "Btn")
					{
						fieldObjectInStream.addProperty("V", fillData, "/");

						if (fieldObjectInStream.getProperty("AS") != null)
						{
							fieldObjectInStream.addProperty("AS", fillData, "/");
						}
					}
					else
					{
						fieldObjectInStream.addProperty("V", escapeTextForTextField(fillData));
					}
				}
	        }
        
			var formXObject = new PdfWriteObject(this.getNextObjectId());
			formXObject.addProperty("Type","ObjStm");
			formXObject.addProperty("Filter", "FlateDecode");
			formXObject.addProperty("N", "1");

			formXObject.addToStream(fieldObjectInStream);
		
			writeObjects.push(formXObject);

			for (var i = 0; i < writeObjects.length; i++)
			{
				this.writeNewObject(writeObjects[i]);
			}
		},

		getXRefParent: function()
		{
			var rootObject = this.getMatchingObjects( { Type: "Catalog" } );

			if (rootObject.length == 1)
			{
				return rootObject[0].getReferenceId();
			}
		},

		getObjectById: function(id)
		{
			if (typeof id == "string")
			{
				id = id.replace("R", "obj");
			}

			if (this.cachedObjectsById[id] != null) 
			{
				return this.cachedObjectsById[id];
			}
			for (var i = 0; i < this.allObjects.length; i++)
			{
				if (this.allObjects[i].Id == id)
				{
					this.cachedObjectsById[id] = this.allObjects[i];
					return this.allObjects[i];
				}

				for (var j = 0; j < this.allObjects[i].streamData.length; j++)
				{
					if (this.allObjects[i].streamData[j].Id == id || this.allObjects[i].streamData[j].Id + " 0 obj" == id)
					{
						this.cachedObjectsById[id] = this.allObjects[i].streamData[j];
						return this.allObjects[i].streamData[j];
					}
				}
			}

			return null;
		}
	}

	var startTime = Date.now();

	function elapsed(message)
	{
		console.log(message + ": " + (Date.now() - startTime)); 
	}

	// Few methods on this object require moment, and should be registered conditionally
	if (window.moment == null){
		console.warn("Moment.js not Loaded. To use the methods fillPdfForm or getAsDate please load Moment.js")
		vPdfWriter.getAsDate = vPdfWriter.fillPdfForm = function(){
			return console.error('Moment.js not Loaded: to use this method please load Moment.js');
		}
	} else{

		vPdfWriter.getAsDate = function(date, options)
		{
			if (date == null)
			{
				return null;
			}

			// http://stackoverflow.com/questions/3143070/javascript-regex-iso-datetime
			var matchArray = date.match(/\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\.\d+([+-][0-2]\d:[0-5]\d|Z)/);

			if (matchArray != null)
			{
				// Default Date Time Formats from moment.js
				var DEFAULTS = { timeFormat: 'h:mm a' , dateFormat: 'MM/DD/YYYY', dateTimeFormat: 'MM/DD/YYYY h:mm a' };
				
				var momentDate = moment(date);

				var format = 'dateTimeFormat';

				if (momentDate.dayOfYear() == 1 && momentDate.year() == 1970)
				{
					 format = 'timeFormat';
				}
				else if (momentDate.hours() == 0 && momentDate.minutes() == 0 && momentDate.seconds() == 0 && momentDate.milliseconds() == 0)
				{
					format = 'dateFormat';
				}

				var stringFormat = options != null ? options[format] : null;

				if (!stringFormat)
				{
					stringFormat = DEFAULTS[format];
				}

				var returnFormatted = momentDate.format(stringFormat);

				if (returnFormatted == 'Invalid Date')
				{
					return date;
				}

				return String(returnFormatted);
			}
			else
			{
				return date;
			}
		}

		vPdfWriter.fillPdfForm = function(pdfData, formJson, options)
		{
			if (getPDFVersion(pdfData) < SUPPORTED_PDF_VERSION) return null;
			
			var pdfDoc = new PdfDocument(pdfData);

			if (options == null) options = {};

			if (options.debug) elapsed("Loaded Pdf");
		
			var allFormFields = pdfDoc.getMatchingObjects( { Type: "Annot" } );

			if (options.debug) elapsed("Found Form Fields");

			for (var i = 0; i < allFormFields.length; i++)
			{
				var formKey = pdfDoc.getPropertyFromObject(allFormFields[i], "T");

				var fieldData = formJson[formKey];

				if (fieldData != null)
				{
					fieldData = this.getAsDate(String(fieldData), options)
			
					pdfDoc.fillField(allFormFields[i], fieldData, options);
					if (options.debug) elapsed("Filled Field " + i);
				}
				else if (options.readOnly)
				{
					pdfDoc.fillField(allFormFields[i], null, options);
				}
			}

			if (options.debug) elapsed("Writing Xref");

			pdfDoc.writeNewXrefStream();

			if (options != null && options.debug)
			{
				elapsed("Filled Form In");
			}

			return pdfDoc.pdfData;
		}
	}

	vPdfWriter.getFormFields = function(pdfData)
	{
		var fields = this.getFormFieldsWithType(pdfData);

		if (fields != null)
		{
			fields = Object.keys(fields);
		}

		return fields;
	}

	vPdfWriter.getFormFieldsWithType = function(pdfData)
	{
		if (getPDFVersion(pdfData) < SUPPORTED_PDF_VERSION) return null;

		var pdfDoc = new PdfDocument(pdfData);

		var formFieldsObject = {};

		var formFields = pdfDoc.getMatchingObjects( { Type: "Annot", Subtype: "Widget", FT: "ALL" } ); 

		var fieldTypeLabels = { Tx: "Text", Ch: "Dropdown", Btn : "Checkbox / Radio Button" };

		formFields.forEach( function(field) {

			if (pdfDoc.getPropertyFromObject(field, "FT") != "Sig")
			{
				formFieldsObject[pdfDoc.getPropertyFromObject(field, "T")] = fieldTypeLabels[pdfDoc.getPropertyFromObject(field, "FT")];
			}
		});

		if (Object.keys(formFieldsObject).length == 0) return null;

	
		return formFieldsObject;
	}

	vPdfWriter.getMatchingFields = function(pdfData, matchingCriteria)
	{
		if (getPDFVersion(pdfData) < SUPPORTED_PDF_VERSION) return null;

		var pdfDoc = new PdfDocument(pdfData);

		var matchingFields = pdfDoc.getMatchingObjects( matchingCriteria ); 
	
		return matchingFields;
	}

	vPdfWriter.expand = function(pdfData)
	{
		if (getPDFVersion(pdfData) < SUPPORTED_PDF_VERSION) return null;

		var pdf = new PdfDocument(pdfData);

		var ret = '';

		for (var i = 0; i < pdf.allObjects.length; i++)
		{
			ret += pdf.allObjects[i].toStringPdf();
		}

		return ret;
	}

	vPdfWriter.getObject = function(pdfData, objId)
	{
		if (getPDFVersion(pdfData) < SUPPORTED_PDF_VERSION) return null;

		var pdf = new PdfDocument(pdfData);
		return pdf.getObjectById(objId);
	}
	
	return vPdfWriter;
}());

try {
if (module != undefined)
{
	module.exports = 
	{
		vlocityPdfWriter: vlocityPdfWriter
	};
}
}
catch(err)
{
	//console.log('Browser');
}

if (typeof window.vlocityPdfWriter === "undefined") {
    window.vlocityPdfWriter = vlocityPdfWriter;
}
