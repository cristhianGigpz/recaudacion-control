import { ipcRenderer } from 'electron'

function operacion(arancel, area, construccion, obrasComp, terreno = 'rustico'){
    //alert(arancel+' '+area+ ' ' +construccion + ' ' +obrasComp + ' ' +terreno)
    let resultado;
    let totgeneral = document.getElementById('totTabla');
    if (terreno == 'rustico'){
      resultado = ((parseFloat(arancel) * parseFloat(area)) + (parseFloat(construccion) + parseFloat(obrasComp))) / 2
      resultado = resultado.toFixed(2)
    }
    if (terreno == 'urbano'){
      resultado = ((parseFloat(arancel) * parseFloat(area)) + (parseFloat(construccion) + parseFloat(obrasComp)))
      resultado = resultado.toFixed(2)
    }
    totFinal+=parseFloat(resultado)
    crearFila(arancel, area, construccion, obrasComp, terreno, resultado)
    //alert(resultado)
    totgeneral.innerHTML = totFinal.toFixed(2)
}

function showDialog(type, title, msg){
    ipcRenderer.send('show-dialog', {type: type, title: title, message: msg})
}
  
function crearFila(arancel, area, construccion, obrasComp, terreno, total) {
  var row= `
  <tr>
    <td>${arancel}</td>
    <td>${area}</td>
    <td>${construccion}</td>
    <td>${obrasComp}</td>
    <td>${terreno}</td>
    <td>${total}</td>
  </tr>
  `;
  let tabla= document.getElementById('destinoFila')
  tabla.insertAdjacentHTML('afterbegin', row)
}

function limpiarInputs(elementoPadre, tipo){
  let elemento = document.getElementById(elementoPadre)
  //elemento = document.getElementById('frmAgregar')
  let inputs = elemento.getElementsByTagName('input')
  for (let i = 0; i < inputs.length; i++) {
    if (inputs[i].type == tipo){
      inputs[i].value = ''
    }
  }
  inputs[0].focus()
}

function pasarFocus(container){
  const elemento = document.getElementById(container)
  let inputs = elemento.querySelectorAll(".form-control")
  alert(inputs.length)
  /*for (let i = 0; i < inputs.length; i++) {
    if (inputs[i].type === 'text'){
      inputs[i].addEventListener('keydown', inputCharacters);
    } 
  }*/
}
// function inputCharacters(event) {
//   if (event.keyCode == 13) {
//     document.getElementById('inputSecond').focus();
//   }
// }

module.exports = {
    crearFila,
    showDialog,
    operacion,
    limpiarInputs,
    pasarFocus
}