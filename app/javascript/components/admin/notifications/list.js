import axios from 'axios'
import NotificationItem from './item'
import Loader from '../misc/loader'

export default {
  name: 'NotificationList',

  methods: {
    getNotifications (mount_items=true) {
      this.loading = true

      axios.get('/admin/notifications')
        .then(response => {
          if (mount_items){
            this.notifications = response.data.notifications
            this.nbUnread = response.data.nb_unviewed
          }
          
          this.loading = false
          this.$emit('updateCount', response.data.nb_unviewed)
        })
        .catch(err => {
          this.error = err
          this.loading = false
        })
    },
    displayAlert (data) {
      this.alert.message = data.error
      this.alert.level = 'warning'
    },
    updateNotifications (id) {
      this.notifications = this.notifications.filter(item => item.id !== id)
      this.$emit('updateCount', this.nbUnread)
    }
  },

  data () {
    return { 
      notifications: [],
      nbUnread: 0,
      error: null,
      loading: false
    }
  },

  render () {
    if (this.loading) {
      return ( <Loader /> )
    }
    
    if (this.notifications.length > 0) {
      return (
          <div>
            <h6 class="dropdown-header bg-dark border-dark">
              Notifications Center
            </h6>
            {this.notifications.map(notification => (
              <NotificationItem 
                notification={notification}
                key={`ope-notification-${notification.id}`}
                onDisplayAlert={this.displayAlert}
                onUpdateNotifications={this.updateNotifications}
              />
            ))}
            <h5 class="text-center pt-3 pb-2">
              <a href="/admin/notifications/latest">Latest Notifications</a>
            </h5>
          </div>
      )
    } else {
      return ( 
        <h5 class="bg-light pt-3 pb-3 text-dark text-center">
          <i class="fa fa-2x fa-check mb-2 text-success"></i><br />No notification
        </h5>
       )
    }
  }
}