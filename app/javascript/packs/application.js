// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// TurbolinksがONの場合、同一のidまたはclassでRatyが反応しなくなるため、OFFとする。
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "script.js"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import Swiper from 'swiper/swiper-bundle.js';  //Swiper
import 'swiper/swiper-bundle.css';  //Swiper

window.Swiper = Swiper;

import Raty from "./raty.js" //raty
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

require("@nathanvda/cocoon") //cocoon

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")

// BootstrapのTooltipを使う
import { Tooltip } from "bootstrap";
$.fn.tooltip = Tooltip._jQueryInterface;
$(function() {
  $('[data-toggle="tooltip"]').tooltip();
})