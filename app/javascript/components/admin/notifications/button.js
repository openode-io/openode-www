import axios from 'axios'
import NotificationList from './list'

export default {
  name: 'NotificationButton',
  data () {
    return {
      count: 0
    }
  },

  methods: {
    updateCount (n) {
      this.count = n 
    }
  },

  render () {
    return(
      <div>
        <a class="nav-link dropdown-toggle" 
          href="#" id="alertsDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">
          <i class="fas fa-bell fa-fw text-light"></i>
          <span class="badge badge-danger badge-counter">{this.count}</span>
        </a>
        <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="alertsDropdown">
            <NotificationList onUpdateCount={this.updateCount}/>
        </div>        
      </div>
    )
  }
}