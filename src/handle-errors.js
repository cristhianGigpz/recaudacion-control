import { dialog } from 'electron'

function relaunchApp(win){
  dialog.showMessageBox(win, {
    type: 'error',
    title: 'Platzipics',
    message: 'Oucrrio un error inesperado, se reiniciará el aplicativo'
  }, ()=> {
    app.relaunchApp()
    app.exit(0)
  })
}

function setupErrors(win){
  win.webContents.on('crashed', () => {
    relaunchApp(win)
  })


  win.on('unresponsive', () =>{
    dialog.showMessageBox(win, {
      type: 'warning',
      title: 'Platzipics',
      message: 'Un proceso esta tardando demasiado, puede esperar o reiniciar el aplicativo'
    })
  })

  process.on('uncaughtException', () => {
    relaunchApp(win)
  })
}

module.exports = setupErrors