//import os from 'os'

import { setIpc, openDirectory, saveFile, pasteImage } from './main-window/ipcRendererEvents'
import createMenu from './main-window/menu'


window.addEventListener('load', () => {
  //console.log(os.cpus())
  createMenu()
  //testConnection()
  setIpc() 
  buttonEvent('open-directory', openDirectory)
  //buttonEvent('open-contribuyente', openWindow)
  buttonEvent('paste-button', pasteImage)
})

function buttonEvent(id, func){
  const openDirectory = document.getElementById(id);
  openDirectory.addEventListener('click', func)
}


function showAllImages(){
  const thumbs = document.querySelectorAll('li.list-group-item img')
    for (let i = 0, length1 = thumbs.length; i < thumbs.length; i++) {
      thumbs[i].parentNode.classList.remove('hidden')
    }
}