import { remote } from 'electron'
//import { operacion, showDialog, limpiarInputs } from './partida-Window/partida-window'

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

