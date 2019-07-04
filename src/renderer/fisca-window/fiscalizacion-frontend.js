import { remote, ipcRenderer } from 'electron'

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

function operacion(arancel, area, construccion, obrasComp, rustico = true){
  if (rustico){
    let resultado = ((arancel * area) + (construccion + obrasComp)) / 2
  }else{
    let resultado = ((arancel * area) + (construccion + obrasComp))
  }
  
}