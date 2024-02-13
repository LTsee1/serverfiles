//$('body').hide()
function updateStatus(id, status) {
  $("#" + id).css("height", status);
  //console.log("STATUS:", id, status, "%")
}

window.addEventListener('message', (event) => {
  const data = event.data
  switch (data.action) {
    case "showhud":
      $('body').show()
      break;
    case 'ToggleRadioList':
      ToggleRadioList(data.toggle);
      break;
    case "hidehud":
      $('body').hide()
      break;
    case 'Updateping':
      let pinghtml = `
          ${data.ping}<span class="smaller">MS</span>
        `;
      $(".ping").html(pinghtml);
      break;
    case "updatePlayerId":
      let idhtml = `
          ${data.id}<span class="smaller">ID</span>
        `;
      $(".id").html(idhtml);
      break;
    case "updateFps":
      let fpshtml = `
            ${data.fps}<span class="smaller">FPS</span>
          `;
      $(".fps").html(fpshtml);
      break;
    case "update":
      updateStatus("armor-status", data.kamza + "%")
      updateStatus("mic-status", data.voice + "%")
      updateStatus("health-status", data.zycie + "%")
      updateStatus("food-status", data.jedzenie + "%")
      updateStatus("water-status", data.woda + "%")
      updateStatus("backpack-status", data.backpack + "%")
      updateStatus("stamina-status", data.zmeczenie + "%")
      //updateStatus("stress-status", data.stress + "%")

      if (parseInt(data.kamza) === 0) {
        $("#armor").css("display", "none");
      } else {
        $("#armor").css("display", "flex");
      }
      if (parseInt(data.voice) === 0) {
        $("#mic").css("display", "none");
      } else {
        $("#mic").css("display", "flex");
      }
      if (parseInt(data.zycie) === 0) {
        $("#health").css("display", "none");
      } else {
        $("#health").css("display", "flex");
      }
      if (parseInt(data.jedzenie) === 0) {
        $("#food").css("display", "none");
      } else {
        $("#food").css("display", "flex");
      }
      if (parseInt(data.woda) === 0) {
        $("#water").css("display", "none");
      } else {
        $("#water").css("display", "flex");
      }
      if (parseInt(data.backpack) === 0) {
        $("#backpack").css("display", "none");
      } else {
        $("#backpack").css("display", "flex");
      }
      if (parseInt(data.zmeczenie) === 0) {
        $("#stamina").css("display", "none");
      } else {
        $("#stamina").css("display", "flex");
      }
      break;
    case 'toggleSpeaking':
      toggleSpeaking(data.toggle);
      break;
    case 'toggleSpeakingIcon':
      toggleSpeakingIcon(data.icon);
      break;
    case 'UpdateCarHud':
      $('.carhud').css("display", "flex")
      $('#street').text(data.street);
      $('#speed').text(data.speed + ' KMH');
      $('#compas').text(data.direction);
      if (Math.abs(parseFloat(data.distanceToWaypoint)) < 0.001) {
        $("#gps-status").css("display", "none");
      } else {
        $('#gps').text(data.distanceToWaypoint + "KM")
        $("#gps-status").css("display", "flex");
      }
      updateStatus("fuel-status", data.fuel + "%")
      break;
    case 'HideCarHud':
      $('.carhud').css("display", "none")
      break;
    case 'notify_js':
      let id = Math.floor((Math.random() * 10000) + 1);

      let notification = $('<div>').addClass('slide-in').attr('id', 'notify' + id);

      notification.html(`
        <div class="notification">
          <div class="notyfication_icon"><i class="${data.icon}"></i></div>
          <div class="notyfication_right">
            <div class="notyfication_title">${data.title}</div>
            <div class="notyfication_desc">${data.message}</div>
          </div>
        </div>
      `);

      $('.notifications').append(notification);

      setTimeout(() => {
        const notificationElement = $('#notify' + id);
        notificationElement.removeClass('slide-in').addClass('unfold');
        setTimeout(() => {
          notificationElement.remove();
        }, 700);
      }, data.duration);
      break;
    case 'progressbar':
      const timeouts = [];
      let typ = 'abc'
      const seconds = Math.floor(data.duration / 1000);

      let value = seconds;
      let startTime = Date.now();

      function update() {
        let elapsed = Date.now() - startTime;
        let t = elapsed / data.duration;
        if (t < 0) t = 0;
        if (t > 1) t = 1;

        let currentValue = (1 - t) * value;
        //$('#sekundy').text(Math.round(currentValue) + 's');

        if (elapsed < data.duration) {
          setTimeout(update, 1);
        }
      }

      update();

      $('.progressbar').show().css('opacity', 1);
      $('.progressbar_label').text(data.label);
      // $('.sekundy').text(seconds + 's');
      $('.progressbar_progres').css('width', typ === 'abc' ? '0%' : '100%').css('transition-duration', '0ms');

      timeouts.push(
        setTimeout(() => {
          timeouts.push(
            setTimeout(() => {
              $('.progressbar_progres').css('transition-duration', data.duration - 200 + 'ms').css('transition-timing-function', 'linear').css('width', typ === 'abc' ? '100%' : '0%');
            }, 200),
          );
          timeouts.push(
            setTimeout(() => {
              $('.progressbar').css('opacity', 0);
            }, data.duration + 1000),
          );
        }, 10),
      );

      break;
    case 'ToggleSettings':
      toggleSettings(true);
      break;
    default:
      break;
  }
})


function toggleSettings(state) {
  switch (state) {
    case true:
      $('.settings').css("display", "flex");
      break;
    case false:
      $('.settings').css("display", "none");
      break;
    default:
      break;
  }
}

function toggleSpeaking(state) {
  switch (state) {
    case true:
      $('#mic').addClass("active")
      break;
    case false:
      $('#mic').removeClass("active")
      break;
    default:
      break;
  }
}

function toggleSpeakingIcon(state) {
  switch (state) {
    case "speaking":
      $("#mic-icon").html(`
        <svg xmlns="http://www.w3.org/2000/svg" width="1.1vw" height="1.1vw" viewBox="0 0 24 24" fill="none"><path d="M12 15.5c2.21 0 4-1.79 4-4V6c0-2.21-1.79-4-4-4S8 3.79 8 6v5.5c0 2.21 1.79 4 4 4Z" stroke="#ffffff97" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M4.35 9.65v1.7C4.35 15.57 7.78 19 12 19c4.22 0 7.65-3.43 7.65-7.65v-1.7M10.61 6.43c.9-.33 1.88-.33 2.78 0M11.2 8.55c.53-.14 1.08-.14 1.61 0M12 19v3" stroke="#ffffff97" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path></svg>                                        
      `)
      //$('#voice').removeClass("fa-solid fa-walkie-talkie");
      //$('#voice').addClass("fa-solid fa-microphone");
      break;
    case "radio":
      $("#mic-icon").html(`
          <svg xmlns="http://www.w3.org/2000/svg" width="1.1vw" height="1.1vw" viewBox="0 0 24 24" fill="none"><path d="M17 5H7c-3 0-5 2-5 5v7c0 3 2 5 5 5h10c3 0 5-2 5-5v-7c0-3-2-5-5-5ZM7 2v3" stroke="#ffffff97" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M8.5 16a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5ZM14.5 11h4M14.5 15h.5M18 15h.5" stroke="#ffffff97" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path></svg>
        `)
      //$('#voice').removeClass("fa-solid fa-microphone");
      //$('#voice').addClass("fa-solid fa-walkie-talkie");
      break;
    default:
      break;
  }
}

function toggleBelt(state) {
  switch (state) {
    case true:
      updateStatus("belt", 100 + "%")
      break;
    case false:
      updateStatus("belt", 0 + "%")
      break;
    default:
      break;
  }
}

function toggleEngine(state) {
  switch (state) {
    case true:
      updateStatus("engine", 100 + "%")
      break;
    case false:
      updateStatus("engine", 0 + "%")
      break;
    default:
      break;
  }
}

$(document).ready(function () {
  let speakerEnabled = true;
  let showList = false;
  let radioList = {};
  let lastChannel = null;

  $(window).on("message", function (event) {
    var item = event.originalEvent.data;
    if (item.radioId != null) {
      let radioListElem = $(".radio-list");
      $(".radiolist").css('display', 'flex');

      if (!radioListElem.firstChild) {

      }
      if (item.radioName != null) {
        radioList[item.radioId] = item.radioName;
        let user = `
                  <div class="radio_user" id="user-${item.radioId}">
                      
                      <div class="name" id="name">${item.radioName}</div>
                      <div class="icon"><i class="fa-light fa-microphone"></i></div>
                  </div>
              `;
        $(".radiolist_bottom").append(user);
      } else if (item.radioTalking != null) {
        if ($("#user-" + item.radioId).hasClass("dead")) return false;
        if (item.radioTalking) {
          $("#user-" + item.radioId).addClass("radioactiveuser");
        } else {
          $("#user-" + item.radioId).removeClass("radioactiveuser");
        }
      } else {
        delete radioList[item.radioId];
        $("#user-" + item.radioId).remove()
      }

      $("#channel").html(item.channel);
      $("#radio_count").html(Object.keys(radioList).length);
    }

    if (item.updateDead != null) {
      $("#user-" + item.radioId).removeClass().addClass(item.bool ? "dead" : "");
    }

    if (item.clearRadioList) {
      radioList = {};
      $(".radiolist_bottom").empty();
    }
  });
});


function ToggleRadioList(state) {
  switch (state) {
    case true:
      $(".radiolist").css('display', 'flex');
      break;
    case false:

      $(".radiolist").css('display', 'none');
      break;
    default:
      break;
  }
}



