'use strict'

const { app, BrowserWindow, Tray, globalShortcut } = require('electron')
import devtools from './devtools'
import setMainIpc from './ipcMainEvents'
import handleErrors from './handle-errors'
import os from 'os'
import path from 'path'


if (process.env.NODE_ENV === 'development') {
  devtools()
  require('electron-reload')
}

global.win //eslint-disable-line
global.tray

app.on('before-quit', () => {
  //console.log('Saliendo...')
  globalShortcut.unregisterAll()
})

app.on('ready', () => {

  // creando una ventana
    global.win = new BrowserWindow({
    width: 800,
    height: 600,
    fullscreen: true,
    title: 'Sistema Integrado de Rentas',
    center: true,
    //maximizable: false,
    show: false,
    webPreferences: {
      nodeIntegration: true
    }
  })

  globalShortcut.register('CommandOrControl+Alt+p', () => {
    global.win.show()
    global.win.focus()
  })

  setMainIpc(global.win)
  handleErrors(global.win)
  

  global.win.once('ready-to-show', () => {
    global.win.show()
  })

  global.win.on('move', () => {
    //const position = global.win.getPosition()
  })

  // detectando el cierre de ventana//
  global.win.on('closed', () => {
    global.win = null
    app.quit()
  })

  let icon
  if (os.platform() === 'win32') {
    icon = path.join(__dirname, 'assets', 'icons', 'tray-icon.ico')
  } else {
    icon = path.join(__dirname, 'assets', 'icons', 'tray-icon.png')
  }

  global.tray = new Tray(icon)
  global.tray.setToolTip('Gigpz')
  global.tray.on('click', () => {
    global.win.isVisible() ? global.win.hide() : global.win.show()
  })


  global.win.loadURL(`file://${__dirname}/renderer/main.html`)
  global.win.toggleDevTools()
  
})

