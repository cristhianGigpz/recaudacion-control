import { remote, ipcRenderer } from "electron";
import { openWindow } from "./ipcRendererEvents";

class UI {
  
  closeFrom(idBtn) {
    const btn = document.getElementById(idBtn);
    if (btn) {
      btn.addEventListener("click", e => {
        const prefsWindow = remote.getCurrentWindow();
        prefsWindow.close();
      });
    }
  }

  
  openWindows(element, ancho, alto, title, file) {
    const btn = document.getElementById(element);
    if (btn) {
      btn.addEventListener("click", e => {
        e.preventDefault();
        openWindow(ancho, alto, title, true, file);
      });
    }
  }
  
  showDialog(options) {
    ipcRenderer.send("showMessageBox", options);
  }

  validateForm(element) {
    let bool = true;
    element.forEach(item => {
      if (item === 0 || item === "") {
        bool = false;
      }
    });
    /*for(let i=0; i<form.elements.length; i++) {
            let elemento = form.elements[i];
            if(elemento.type != radio && (elemento.value === 0 || elemento.value ==='')){
                bool = false;
            }
        }*/
    return bool;
  }
  initFocus(form){
    for (let i = 0; i < form.elements.length; i++) {
      let elemento = form.elements[i];
      if (elemento.type == "text" ){
        elemento.focus()
        break;
      }
    }
  }
  clearElements(form){
    for (let i = 0; i < form.elements.length; i++) {
      let elemento = form.elements[i];
      if (elemento.type == "text" ) elemento.value="";
      if (elemento.type == "radio") elemento.checked = false;
      if (elemento.type == "checkbox") elemento.checked = 0;
      if (elemento.type == "hidden") elemento.value= 0;
      if (
        elemento.type != "hidden" &&
        elemento.type != "text" &&
        elemento.type != "radio" &&
        elemento.type != "checkbox"
      ) {
        elemento.value = "";
      }
    }
  }

  pasarFocus(form){
    let formulario = document.getElementById(form);
    const inputs = formulario.querySelectorAll("input[type='text']");
    //console.log(inputs);
    for (let i = 0; i < inputs.length; i++) {
      inputs[i].addEventListener('keyup', (e) => {
        if (e.keyCode === 13){
          //alert('enter: ' + e.target.id)
          //console.log(i);
          i < inputs.length - 1 ? inputs[i+1].focus() : inputs[0].focus()
        }
      })
    }
    /* inputs.forEach((item, key) => {
      //console.log("datos "+ key)
      item.addEventListener('keyup', (e) => {
        if (e.keyCode === 13){
          alert('enter: ' + e.target.id)
        }
      })
    }) */
  }
  
  valuesElements(elements) {
    let datos = [];
    for (let i = 0; i < elements.length; i++) {
      let elemento = elements[i];
      //if(elemento.type != radio && (elemento.value === 0 || elemento.value ==='')){
      if (
        elemento.type == "text" ||
        (elemento.type == "radio" && elemento.checked)
      ) {
        datos.push(elemento.value);
      }
      if (elemento.type == "checkbox") {
        let valor = elemento.checked ? 1 : 0;
        datos.push(valor);
      }
      if (
        elemento.type != "hidden" &&
        elemento.type != "text" &&
        elemento.type != "radio" &&
        elemento.type != "checkbox"
      ) {
        datos.push(elemento.value);
      }
    }
    return datos;
  }
}
export default UI;
