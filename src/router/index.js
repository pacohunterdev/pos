import Vue from 'vue'
import VueRouter from 'vue-router'
import ProductosComponent from '@/components/Inventario/ProductosComponent'
import AgregarProducto from '@/components/Inventario/AgregarProducto'
import EditarProducto from '@/components/Inventario/EditarProducto'
import MarcasCategorias from '@/components/MarcasCategorias/MarcasCategorias'
import RealizarVenta from '@/components/Ventas/RealizarVenta'
import ReporteVentas from '@/components/Ventas/ReporteVentas'
import ReporteCuentas from '@/components/Ventas/ReporteCuentas'
import ReporteApartados from '@/components/Ventas/ReporteApartados'
import ReporteCotizaciones from '@/components/Ventas/ReporteCotizaciones'
import ClientesComponent from '@/components/Clientes/ClientesComponent'
import AgregarCliente from '@/components/Clientes/AgregarCliente'
import EditarCliente from '@/components/Clientes/EditarCliente'
import UsuariosComponent from '@/components/Usuarios/UsuariosComponent'
import AgregarUsuario from '@/components/Usuarios/AgregarUsuario'
import EditarUsuario from '@/components/Usuarios/EditarUsuario'
import ConfiguracionComponent from '@/components/Configuracion/ConfiguracionComponent'
import PerfilComponent from '@/components/Usuarios/PerfilComponent'
import CambiarPassword from '@/components/Usuarios/CambiarPassword'
import InicioComponent from '@/components/InicioComponent'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'InicioComponent',
    component: InicioComponent
  },
  {
    path: '/inventario',
    name: 'ProductosComponent',
    component: ProductosComponent
  },  
  {
    path: '/agregar-producto',
    name: 'AgregarProducto',
    component: AgregarProducto
  },  
  {
    path: '/editar-producto/:id',
    name: 'EditarProducto',
    component: EditarProducto
  },
  {
    path: '/marcas-y-categorias',
    name: 'MarcasCategorias',
    component: MarcasCategorias
  },
  {
    path: '/realizar-venta',
    name: 'RealizarVenta',
    component: RealizarVenta
  },  
  {
    path: '/reporte-ventas',
    name: 'ReporteVentas',
    component: ReporteVentas
  },  
  {
    path: '/reporte-cuentas',
    name: 'ReporteCuentas',
    component: ReporteCuentas
  },  
  {
    path: '/reporte-apartados',
    name: 'ReporteApartados',
    component: ReporteApartados
  },  
  {
    path: '/reporte-cotizaciones',
    name: 'ReporteCotizaciones',
    component: ReporteCotizaciones
  },
  {
    path: '/clientes',
    name: 'ClientesComponent',
    component: ClientesComponent
  }, 
  {
    path: '/agregar-cliente',
    name: 'AgregarCliente',
    component: AgregarCliente
  },
  {
    path: '/editar-cliente/:id',
    name: 'EditarCliente',
    component: EditarCliente
  },  
  {
    path: '/usuarios',
    name: 'UsuariosComponent',
    component: UsuariosComponent
  },  
  {
    path: '/agregar-usuario',
    name: 'AgregarUsuario',
    component: AgregarUsuario
  },
  {
    path: '/editar-usuario/:id',
    name: 'EditarUsuario',
    component: EditarUsuario
  },  
  {
    path: '/configurar',
    name: 'ConfiguracionComponent',
    component: ConfiguracionComponent
  },
  {
    path: '/perfil',
    name: 'PerfilComponent',
    component: PerfilComponent
  },  
  {
    path: '/cambiar-password',
    name: 'CambiarPassword',
    component: CambiarPassword
  },

]

const router = new VueRouter({
  routes
})

export default router
