import UI from './main-window/ui'
const ui = new UI();

/**
 * Load Events
 */
window.addEventListener('DOMContentLoaded',()=>{
    NewDdata();
    SaveButton();
    LoadData();
    printPDF();
});

/**
 * Listado de Departamento
 */
const LoadData =()=>{
    const element = ui.loadGetData('departamento');
    element.then((e)=>{LoaderData(e)})
    //cerrar formulario
    ui.closeFrom('cancel-button');
}

const SaveButton =()=>{
    document.getElementById('btn-guardar').addEventListener('click',(e)=>{
        e.preventDefault();
        const _name = document.getElementById('dep').value;
        const element = ui.insertData('INSERT INTO departamento(nombre_departamento) VALUES($1);',[_name],'departamento');
        element.then((e)=>{LoaderData(e)})
    })
}
const printPDF =()=>{
    const  btnPrint = document.getElementById('print-pdf');
    btnPrint.addEventListener('click',(event)=>{
       // ui.pdfPrint();
       const invoice = {
        shipping: {
          name: "John Doe",
          address: "1234 Main Street",
          city: "San Francisco",
          state: "CA",
          country: "US",
          postal_code: 94111
        },
        items: [
          {
            item: "TC 100",
            description: "Toner Cartridge",
            quantity: 2,
            amount: 6000
          },
          {
            item: "USB_EXT",
            description: "USB Cable Extender",
            quantity: 1,
            amount: 2000
          }
        ],
        subtotal: 8000,
        paid: 0,
        invoice_nr: 1234
      };
       ui.createInvoice(invoice,'reportePDF.pdf')
    })
}
/*
const EditButton =()=>{
    document.getElementById('edit').addEventListener('click',(e)=>{
        e.preventDefault();
       
       alert('data para editar')
    })
}*/
const NewDdata =()=>{
    document.getElementById('new-data').addEventListener('click',()=>{
       alert('nuevo');
    })
}
const EditButton =()=>{
    let el = document.createElement('button');
    el.id='edit';
    el.innerHTML =`<span class="icon icon-pencil"></span>`;
    el.addEventListener('click',()=>{
        alert('click')
    });
    /*document.body.appendChild(el);*/

    //return el.outerHTML;
    return el;
}
/**
 * 
 * @param {matriz departamento} items 
 */
const LoaderData=(items)=>{
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.iddepartamento}</td>
                <td>${e.nombre_departamento}</td>
                <td id="list">
                    ${EditButton()}
                    <button id="remove"><span class="icon icon-cancel"></span></button>
                </td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}