
let nId = 0
let notificationid = 99

function showNewNotify(data)
  {
    //
    notificationid++
    let curid = notificationid
    let alert_class = data.blink && 'alert-body blink' || 'alert-body'
    let item = `    
      <div class="alert fade-left-enter" id="notify_${curid}">
        <div class='${alert_class}'>


        <label class="title">
        ${data.title}
        </label>
        
        <label class="code-badge">
          ${data.code}
        </label>
        <label class="police-count">
              0/6
        </label>



        <div class="alert-desc">
        ${data.description}
        </div>
    
    
        <button class='button-15' id="btn_${curid}" >
            Ustaw GPS
        </button>
        <button class='button-15' id="btn_${curid}" >
            Reaguj
            
        </button>
      
        <div class="life-bar">
          <div class="bar" id="bar_${curid}"> </div>
        </div>
      

    </div>
  </div>
    `
    const duration =  5000

    
    
    $("#notification_list").append(item)
  
    $( `#bar_${curid}`).animate({
      width:'0%'
    },duration)
    

      
      setTimeout(() => {
        $(`#notify_${curid}`).removeClass('fade-left-enter')
        $(`#notify_${curid}`).addClass('fade-left-leave')
        setTimeout(() => {
          $(`#notify_${curid}`).remove();
        },
        250);
      }, duration);
    
    //
  }
//

function NewNotify(data) {
  showNewNotify(data)
  var currentdate = new Date();

  var datetime =  currentdate.getHours() + ":"  + currentdate.getMinutes() + ":" + currentdate.getSeconds();
  nId++
  let curid = data.id || nId
  let alert_class = data.blink && 'alert-body blink' || 'alert-body'
  let item = `    
    <div class="alert fade-left-enter" id="notify_${curid}">
      <div class='${alert_class}'>

          <div class="alert-topbar">
              <button class="alert-close" id="btn_${curid}_delete">
                X
              </button>
              <div class="alert-create-time">
                ${datetime}
              </div>
          </div>
        

          <label class="title">
              ${data.title}
          </label>
          
          <label class="code-badge">
          ${data.code}
          </label>
          <label class="police-count" id="unit_count_${curid}" >
                0/6
          </label>
          <div class="police-radio" id="radio_${curid}">
              Radio: ${data.Radio || "Brak"}
          </div>


          <div class="alert-desc">
              ${data.description}
          </div>
      
      
          <button class='button-15' id="btn_${curid}" >
              Ustaw GPS
          </button>
          <button class='button-15' id="btn_join_${curid}" >
              Reaguj
          </button>
      </div>
    </div>
`
$("#alert-list").append(item)
    

  $( `#btn_${curid}`).click(function()
  {  
    $.post('http://dispatch/dispatch:SetGPS', JSON.stringify({coordinates: data.coordinates}))
  });
  $( `#btn_join_${curid}`).click(function()
  {  
    $.post('http://dispatch/dispatch:Join', JSON.stringify({id: curid}))
  });

  $( `#btn_${curid}_delete`).click(function()
  { 
    $(`#notify_${curid}`).addClass('fade-left-leave') 
    setTimeout(() => {
      $(`#notify_${curid}`).remove();
    },
    250);
  });
}


window.addEventListener('message', function(event) {
  if (event.data.action == 'AddUnit') {
      let p_count = $(`#unit_count_${event.data.id}`)
      p_count.html(`${event.data.dispatch_data.units.length}/${event.data.dispatch_data.max_units}`)
      if (event.data.radio != null) {
        let radio_t = $(`#radio_${event.data.id}`)
        radio_t.html(`Radio: ${event.data.radio}`)
      } 
  }

  if (event.data.action == 'focus') {
    let alertlist = $("#alert-list");
    let notification_list = $("#notification_list")
    if (event.data.focus) {
      alertlist.show();
      alertlist.addClass("alert-list-open");  
      notification_list.hide()

    } else {
      alertlist.removeClass("alert-list-open");
 
      alertlist.hide()

    notification_list.show();
    }
  }
  if (event.data.action == "ShowNotification") {
    event.data.list.forEach(data => {
      showNewNotify(data)
    });
  }

  if (event.data.action == 'NewNotify') {
    let alertlist = document.getElementsByClassName("alert-list");
    event.data.list.forEach(data => {
      NewNotify(data)
    });

  }

});


// quit

document.onkeyup = function(event) {
    if (event.key === "Escape") {
      $.post('http://dispatch/dispatch:UnFocus', JSON.stringify({}))
    }
};