import { remote } from 'electron'
import { operacion, showDialog, limpiarInputs, pasarFocus } from './fisca-Window/util-fisca'

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
  //pasarFocus(form)
  //if (validateForm(form)) {
    let inputs = form.getElementsByTagName('input')
    for (let i = 0; i < inputs.length; i++) {
      if (inputs[i].type == 'text' || (inputs[i].type == 'radio' && inputs[i].checked)){
        if(inputs[i].value.trim() === "" && inputs[i].required === true) {
              alert("Digite el valor " + ' del ' + " campo");
              inputs[i].focus();
              inputs[i].style.borderColor = "red";
              inputs[i].style.borderStyle = "dashed";
              return false;
        }else{
          data.push(inputs[i].value)
        }
      }
    }
    //let datos = data.toString().split(",");
    //alert(datos[0]+' '+datos[1]+' '+datos[2]+' '+ datos[3]+ ' '+ datos[4])
    if (data.length>0){
      operacion(data[0],data[1],data[2],data[3],data[4])
      limpiarInputs('frmAgregar', 'text')
    }
  //}
})
