import axios from 'axios'

export default {
  name: 'Delete',

  props: {
    instance: Object
  },

  methods: {
    deleteInstance () {
      if (!confirm('Are you sure?')) {
        return
      }

      this.processing = true

      this.status = {
        message: 'deleting',
        level: 'warning',
        icon: 'fa fa-spin fa-spinner'
      }

      this.button = {
        text: 'Deleting...',
        disabled: true,
        icon: 'fa fa-spin fa-spinner'
      }

      this.$emit('updateStatus', { status: this.status, processing: this.processing, poll: false })

      axios.post(`/admin/instances/${this.instance.id}/delete.json`)
        .then(response => {
          this.status = response.data.status
          this.processing = false

          this.button = {
            text: 'Delete',
            disabled: false
          }

          this.$emit('updateStatus', { status: this.status, processing: this.processing, poll: true })
        })
        .catch(err => {
          this.button = {
            text: 'Delete',
            disabled: false
          }
                    
          this.$emit('displayError', { error: err })          
        })
    }
  },

  data () {
    return {
      button: {
        text: 'Delete',
        disabled: false,
        icon: 'fa fa-trash'
      },
      status: this.instance.status,
      processing: false
    }
  },

  render () {
    if (this.instance.status.message !== 'offline') {
      return ''
    }

    return (
      <button type='button' class='dropdown-item'
        onClick={this.deleteInstance}
        disabled={this.button.disabled}>
        <i class={this.button.icon} /> {this.button.text}
      </button>
    )
  }
}
