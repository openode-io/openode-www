import axios from 'axios'
import NotificationItem from './item'
import Loader from '../misc/loader'

export default {
  name: 'NotificationList',

  methods: {
    getNotifications () {
      this.loading = true

      axios.get('/admin/notifications')
        .then(response => {
          this.notifications = response.data.notifications
          console.log(`this.notifications = `, this.notifications)
          this.loading = false
          this.$emit('updateCount', this.notifications.length)
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
      this.$emit('updateCount', this.notifications.length)
    }
  },

  data () {
    return { 
      notifications: [],
      error: null,
      loading: false
    }
  },

  mounted () {
    this.getNotifications()
  },

  render () {
    if (this.loading) {
      return ( <Loader /> )
    }
    
    if (this.notifications.length > 0) {
      return (
          <div>
            <h6 class="dropdown-header bg-dark border-dark">
              Alerts Center
            </h6>
            {this.notifications.map(notification => (
              <NotificationItem 
                notification={notification}
                key={`ope-notification-${notification.id}`}
                onDisplayAlert={this.displayAlert}
                onUpdateNotifications={this.updateNotifications}
              />
            ))}
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