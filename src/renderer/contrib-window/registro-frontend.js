import { remote, ipcRenderer } from 'electron';
import UI from './main-window/ui'
const ui = new UI();
window.addEventListener('load', () => {
    closeRegistroContribuyente();
})
const closeRegistroContribuyente=()=>{
    ui.closeFrom('reg-contribuyente-end');
}