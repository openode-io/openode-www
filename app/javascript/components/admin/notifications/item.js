import axios from 'axios'

export default {
  name: 'NotificationItem',

  props: {
    notification: Object
  },

  methods: {
    markRead (remove_from_list=false) {
      this.updating = true

      if (remove_from_list) {
        this.visibility = 'd-sm-none'
        this.$emit('updateNotifications', this.notification.id)
      }

      axios.post(`/admin/notifications/${this.notification.id}/mark_read.json`)
        .then(response => {
          this.status = response.data.status
          this.updating = false          
        })
        .catch(err => {          
          this.$emit('displayError', { error: err })          
        })      
    },
    
    displayError (error) {
      this.$emit('onDisplayAlert',{error:error})
    }
  },

  mounted () {
    this.markRead(false)
  },

  data () {
    return {
      status: this.notification.status,
      updating: false,
      visibility: 'd-block'
    }
  },

  render () {
    return (
      <a class={`dropdown-item d-flex align-items-center ${this.visibility}`} href="#" >
        <div class="mr-3">
        <i class={`fas fa-circle fa-2x text-${this.notification.level}`}></i>
        </div>
        <div>
          <div class="small text-gray-500">{this.notification.date}</div>
          <span 
            class={`font-weight-${(this.notification.status == 'read' ? 'bold' : 'light')}`}
            domPropsInnerHTML={this.notification.content}
            >
            {this.notification.content}
          </span>
        </div>
      </a>      
    )
  }
}