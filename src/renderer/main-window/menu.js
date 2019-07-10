import { remote } from 'electron'
import { openDirectory, saveFile, openWindow, openContribuyente, uploadImage, pasteImage } from './ipcRendererEvents'
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
          label:'Departamento',
          click(){openWindow(595,455,'Departamento',true,'departamento')}
        },
        {
          label:'Provincia',
          click(){openWindow(595,455,'Provincia',true,'provincia')}
        },
        {
          label:'Distrito',
          click(){openWindow(745,530,'Distrito',true,'distrito')}
        },
        {
          label:'Urbanisacion',
          click(){openWindow(745,530,'Urbanisacion',true,'urbanisacion')}
        },
        {
          label: 'Contribuyente',
          accelerator: 'CmdOrCtrl+T',
          click () { openWindow(1230, 610, 'Contribuyente', true, 'listadoContribuyente') }
        }
      ]
    },
    {
      label: 'FISCALIZACION',
      submenu: [
        {
          label: 'Acta',
          accelerator: 'CmdOrCtrl+F',
          click () { openWindow(580, 600,'Fiscalizacion', true, 'fiscalizacion') } //openWindow(ancho, alto, titulo, center = true, plantilla)
        },
        {
          label: 'Otra opcion',
          click () { openContribuyente() }
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