const { ipcMain, dialog } = require('electron')
import fs from 'fs'
import isImage from 'is-image'
import filesize from 'filesize'
import path from 'path'

function setMainIpc(win) {

  ipcMain.on('connection', (event, usuario)=>{
    console.log(usuario)
    //win.webContents.send('conectado', usuario)// Envia a su render (main.html)
    //event.reply('asynchronous-reply', 'pong') //Devuelve respuesta al recibir evento
    //event.returnValue = 'pong' //?
    event.sender.send('conectado', usuario) //Envia respuesta al ipcRender que envio el evento (contribuyente-frontend.js)
  })


  ipcMain.on('open-directory', (event)=>{
    dialog.showOpenDialog(win, {
      title: 'seleccione la nueva ubicacion',
      buttonLabel: 'Abrir ubicacion',
      properties: ['openDirectory']
    },
    (dir)=>{
      const images = []
      if (dir) {
        loadImages(event, dir[0])
      }
    })
    //event.sender.send('pong', new Date())
  })


  ipcMain.on('load-directory', (event, dir)=>{
    loadImages(event, dir)
  })

  ipcMain.on('open-save-dialog', (event, ext)=>{
    //console.log(ext)
    dialog.showSaveDialog(win, {
      title: 'Guardar imagen modificada',
      buttonLabel: 'Guardar Imagen',
      filters: [{name: 'Images', extensions: [ext.substr(1)] }]
    }, (file) => {
      //console.log(file)
      if (file){
        event.sender.send('save-image', file)
      }
    })
  })



    ipcMain.on('show-dialog', (event, info) => {
      dialog.showMessageBox(win, {
        type: info.type,
        title: info.title,
        message: info.message
      })
    })

}


function loadImages(event, dir){
  const images = []
  fs.readdir(dir, (err, files)=>{
    if (err) throw err
    for (let i = 0; i < files.length; i++) {
      if (isImage(files[i])){
        let imageFile = path.join(dir, files[i])
        let stats = fs.statSync(imageFile)
        let size = filesize(stats.size , {round: 0})
        //images.push(files[i])
        images.push({filename: files[i], src: `file://${imageFile}`, size: size })
      }
    }
    //console.log(images)
    event.sender.send('load-images', dir, images)
  })
}

module.exports = setMainIpc