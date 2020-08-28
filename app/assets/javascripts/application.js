// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .
$(document).on('turbolinks:load', function () {
  $("#theTarget").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'slide',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'block',
    // 子要素の種類("div" or "img")
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 3000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});





$(function(){

  function insertStr(input){
    return input.slice(0, 3) + '-' + input.slice(3,input.length);
  }

  $("#client_postal_code , #shipping_address_postal_code").on('keyup',function(e){
    var input = $(this).val();

    var key = event.keyCode || event.charCode;
    if( key == 8 || key == 46 ){
      return false;
    }

    if(input.length === 3){
      $(this).val(insertStr(input));
    }
  });

  $("#client_postal_code , #shipping_address_postal_code").on('blur',function(e){
    var input = $(this).val();

    if(input.length >= 3 && input.substr(3,1) !== '-'){
      $(this).val(insertStr(input));
    }
  });
}
)
