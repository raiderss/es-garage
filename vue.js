

const app = new Vue({
  el: '#app',
  data: {
    impound:0,
    searchQuery:'',
    ui:false,
    features: [
      { label: 'Speed', value: 70 },
      { label: 'Fuel', value: 40 },
      { label: 'Durability', value: 60 },
    ],
    select:{
      name: 'Albany Hern', plate :'TEST2', id : 1, located : 'TEST', state : 0
    },
    car:[]
   },
   methods: {

    openUrl(url) {
      window.invokeNative("openUrl", url);
      window.open(url, '_blank');
    },

    parked(){
      $.post(`https://${GetParentResourceName()}/Parked`, JSON.stringify(this.select.plate));
    },

    spawn(){
      $.post(`https://${GetParentResourceName()}/SpawnVehicle`, JSON.stringify(this.select));
    },

    info(item){
      this.select = {
        name : item.title,
        plate : item.plate,
        id : item.id,
        located: item.location,
        state : item.state,
        vehicle : item.model,
        mods : item.mods
      }
      $.post(`https://${GetParentResourceName()}/VehicleInfo`, JSON.stringify({data:item}), function(data){
        app.features = [
          { label: 'Speed', value: Math.floor(data.speed) },
          { label: 'Fuel', value: Math.floor(data.fuel) },
          { label: 'Durability', value: Math.floor(data.traction) },
        ];
      });
    },
      handleEventMessage(event) {
        const item = event.data;
        switch (item.data) {
          case 'GARAGE':
            this.ui = true;
            this.car = item.car;
            this.info(item.car[0]);
            let stateZeroCount = 0;
            if (Array.isArray(this.car)) {
              stateZeroCount = this.car.filter(c => c.state === 0).length;
            } else if (this.car.state === 0) {
              stateZeroCount = 1;
            }
            this.impound = stateZeroCount;
            // console.log(` DÜŞ ARTIK A ${stateZeroCount}`);
            if (typeof this.car.mods === 'string') {
              try {
                this.car.mods = JSON.parse(this.car.mods);
              } catch (e) {
                console.error('JSON:', e);
              }
            }
            break;
            case 'CLOSE':
              this.ui = false;
              $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
            break
        }
    },   
  }, 
    computed: {
      filteredCars() {
        return this.car.filter(vehicle => {
          return vehicle.title.toLowerCase().includes(this.searchQuery.toLowerCase());
        });
      }
    },
     mounted() {
      const hasVisited = localStorage.getItem('hasVisitedEyestore');
      if (!hasVisited) {
        this.openUrl('https://eyestore.tebex.io');
        localStorage.setItem('hasVisitedEyestore', 'true');
      }
    },
    created() {
      window.addEventListener('message', this.handleEventMessage);
    },
  })
  document.onkeyup = function (data) {
    if (data.which == 27) {
      app.ui = false;
      $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
  };
  let holding = false;
  let direction = "", oldx = 0;
  document.addEventListener('mousedown', (e) => holding = true);
  document.addEventListener('mouseup', (e) => holding = false);
  document.addEventListener('mousemove', function(e) {
      if (e.pageX < oldx) { direction = "left" } else if (e.pageX > oldx) { direction = "right" }
      oldx = e.pageX;
      if (direction == "left" && holding) {
          if (e.target.classList.contains("move")) {
              $.post(`https://${GetParentResourceName()}/rotateright`);
          }
      }
      if (direction == "right" && holding) {
          if (e.target.classList.contains("move")) {
              $.post(`https://${GetParentResourceName()}/rotateleft`);
          }
      }
  });
  
  document.addEventListener('wheel', function(e) {
      if (e.target.classList.contains("move")) {
          if (e.deltaY < 0) {
              $.post(`https://${GetParentResourceName()}/zoomIn`);
          } else {
              $.post(`https://${GetParentResourceName()}/zoomOut`);
          }
      }
  });
  
