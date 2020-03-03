import axios from 'axios'
import NotificationList from './list'

export default {
  name: 'NotificationButton',

  data () {
    return {
      count: 1
    }
  },

  methods: {
    updateCount (n) {
      this.count = n
    },
    getNotifications(mark_all_read=false) {
      this.$refs.notificationList.getNotifications(mark_all_read)
    }
  },

  mounted () {
    this.getNotifications(false)
  },

  render () {
    return(
      <div>
        <a class="nav-link dropdown-toggle" 
          href="#" id="alertsDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
          onClick={this.getNotifications}>
          <i class="fas fa-bell fa-fw text-light"></i>
          <i class={`fa fa-circle text-critical badge-counter ${(this.count > 0) ? 'd-block' : 'd-none'}`}></i>
        </a>
        <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="alertsDropdown">
            <NotificationList onUpdateCount={this.updateCount} ref="notificationList"/>
        </div>        
      </div>
    )
  }
}