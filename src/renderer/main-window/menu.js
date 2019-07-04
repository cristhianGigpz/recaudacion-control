import { remote } from 'electron'
import { openDirectory, saveFile, openWindow, uploadImage, pasteImage } from './ipcRendererEvents'
//import { print } from './images-ui'

function createMenu () {
  const template = [
    {
      label: 'ARCHIVO',
      submenu: [
        {
          label: 'Abrir',
          accelerator: 'CmdOrCtrl+A',
          click () { openDirectory() }
        },
        {
          label: 'Salir',
          role: 'quit'
        }
      ]
    },
    {
      label: 'RENTAS',
      submenu: [
        {
          label: 'Contribuyente',
          accelerator: 'CmdOrCtrl+T',
          click () { openWindow(600, 500, 'Contribuyente', true, 'contribuyente') }
        }
      ]
    },
    {
      label: 'FISCALIZACION',
      submenu: [
        {
          label: 'Acta',
          accelerator: 'CmdOrCtrl+F',
          click () { openWindow(500, 600,'Fiscalizacion', true, 'fiscalizacion') } //openWindow(ancho, alto, titulo, center = true, plantilla)
        },
        {
          label: 'Otra opcion'
          //click () { pasteImage() }
        }
      ]
    },
    {
      label: 'CAJA',
      submenu: [
        {
          label: 'Imprimir',
          accelerator: 'CmdOrCtrl+P',
          //click () { print() }
        },
        {
          label: 'Pegar imagen',
          accelerator: 'CmdOrCtrl+V',
          click () { pasteImage() }
        }
      ]
    },
    {
      label: 'COACTIVO'
    }
  ]
  const menu = remote.Menu.buildFromTemplate(template)
  remote.Menu.setApplicationMenu(menu)
}

module.exports = createMenu