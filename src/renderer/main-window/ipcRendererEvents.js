import { ipcRenderer, clipboard, remote, shell } from 'electron'
import settings from 'electron-settings'

import os from 'os'
import path from 'path'


const { Client, Pool } = require('pg')
require('custom-env').env('config')

let usuario = {};

function setIpc(){
  if (settings.has('directory')){
    ipcRenderer.send('load-directory', settings.get('directory'))
  }

  ipcRenderer.on('load-images', (event, dir, images)=>{
    
    settings.set('directory', dir)
    //document.getElementById('directory').innerHTML = dir
    //console.log(settings.file())
  })

  ipcRenderer.on('save-image', (event, file)=>{
    //console.log(file)
    
  })

  /*ipcRenderer.on('conectado', (event, file)=>{
    console.log('usuario conectado!')
  })*/
}


/* function sendIpc(){
  ipcRenderer.send('ping', new Date())
} */
function showDialog(type, title, msg){
  ipcRenderer.send('show-dialog', {type: type, title: title, message: msg})

}

function openContribuyente() {
  const BrowserWindow = remote.BrowserWindow
  const mainWindow = remote.getGlobal('win')

  const contribWindow = new BrowserWindow({
    width: 600,
    height: 500,
    title: 'Contribuyentes',
    center: true,
    modal: true,
    frame: false,
    show: false,
  })

  if (os.platform() !== 'win32') {
    contribWindow.setParentWindow(mainWindow)
  } 
  contribWindow.once('ready-to-show', ()=>{
    contribWindow.show()
    contribWindow.focus()
  })
  contribWindow.loadURL(`file://${path.join(__dirname, '..')}/contribuyente.html`)
}


function openWindow(ancho, alto, titulo, center = true, plantilla){
  const BrowserWindow = remote.BrowserWindow
  const mainWindow = remote.getGlobal('win')
  const ventana = new BrowserWindow({
    width: ancho,
    height: alto,
    title: titulo,
    center: center,
    parent: mainWindow,
    modal: true,
    show: false,
    frame: false
  })

  if (os.platform() !== 'win32') {
    ventana.setParentWindow(mainWindow)
  } 
  ventana.once('ready-to-show', ()=>{
    ventana.show()
    ventana.focus()
  })

  ventana.loadURL(`file://${path.join(__dirname, '..')}/${plantilla}.html`)

}


function openDirectory(){
  ipcRenderer.send('open-directory')
}

function saveFile(){
  const image = document.getElementById('image-displayed').dataset.original
  const ext = path.extname(image)
  ipcRenderer.send('open-save-dialog', ext)
}

function pasteImage () {
  const image = clipboard.readImage()
  const data = image.toDataURL()
  if (data.indexOf('data:image/png;base64') !== -1 && !image.isEmpty()) {
    let mainImage = document.getElementById('image-displayed')
    mainImage.src = data
    mainImage.dataset.original = data
  } else {
    showDialog('error', 'Platzipics', 'No hay una imagen valida en el portapapeles')
  }
}

module.exports = {
  setIpc: setIpc,
  openDirectory: openDirectory,
  saveFile: saveFile,
  openContribuyente: openContribuyente,
  openWindow: openWindow,
  pasteImage: pasteImage
}
