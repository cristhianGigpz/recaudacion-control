import { remote, ipcRenderer } from 'electron'
import { operacion, showDialog, limpiarInputs, validateForm } from './fisca-Window/util-fisca'

let totFinal=0;
window.addEventListener('load', () => {
  cancelButton()
  //testConnection()
})

function cancelButton () {
  const cancelButton = document.getElementById('cancel-button')

  cancelButton.addEventListener('click', () => {
    const prefsWindow = remote.getCurrentWindow()
    prefsWindow.close()
  })
}


document.getElementById('btnAgregar').addEventListener('click', function(event){
  //showDialog('info', 'Aviso', 'Se ha agregado el registro')
  let data = []
  event.preventDefault()
  const form = document.getElementById('frmAgregar')
  //if (validateForm(form)) {
      let inputs = form.getElementsByTagName('input')
    for (let i = 0; i < inputs.length; i++) {
      if (inputs[i].type == 'text' || (inputs[i].type == 'radio' && inputs[i].checked)){
        data.push(inputs[i].value)
      }
    }
    //let datos = data.toString().split(",");
    //alert(datos[0]+' '+datos[1]+' '+datos[2]+' '+ datos[3]+ ' '+ datos[4])
    operacion(data[0],data[1],data[2],data[3],data[4])
    limpiarInputs('frmAgregar', 'text')
  //}
})

// document.getElementById('inputFirst').addEventListener('keydown', inputCharacters);
// function inputCharacters(event) {
//   if (event.keyCode == 13) {
//     document.getElementById('inputSecond').focus();
//   }
// }

