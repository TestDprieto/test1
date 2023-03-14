/** A method used by Flex designer to load/ update design time custom styling */
window.flexLoadCustomStylesheet = function(url){
    //Looking for stylesheet with same unique url
    let existing = document.querySelector('link[href="'+url+'"]');
    let header = document.getElementsByTagName("head")[0];
    let stylesheet=document.createElement("link");
    stylesheet.setAttribute("rel", "stylesheet")
    stylesheet.setAttribute("type", "text/css");
    stylesheet.setAttribute("href", url);
    header.appendChild(stylesheet);
    //Now removing the previously loaded stylesheet, if any
    if(existing){
        header.removeChild(existing);
    } 
}