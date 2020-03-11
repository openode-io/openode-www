import InstanceList from './components/admin/instances/list'
import DeploymentList from './components/admin/instances/deployments/list'
import NotificationButton from './components/admin/notifications/button'
import OpenodeTerminal from './components/admin/misc/openode_terminal'

export const InstanceListInstance = {
  el: '.vue-instances',
  component: InstanceList
}

export const InstanceDeploymentListInstance = {
  el: '.vue-instance-deployments',
  component: DeploymentList
}

export const NotificationButtonInstance = {
  el: '.vue-notifications',
  component: NotificationButton
}