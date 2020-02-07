import Deploy from './actions/deploy'
import Stop from './actions/stop'
import Delete from './actions/delete'

export default {
  name: 'InstanceCard',

  props: {
    instance: Object
  },

  methods: {
    updateStatus (data) {
      this.status = data.status
      this.processing = data.processing

      if (data.poll) {
        this.$emit('pollInstancesStatus')
      }        
    },
    
    displayAlert (error) {
      this.$emit('displayAlert',error)
    }
  },

  data () {
    return {
      status: this.instance.status,
      processing: false
    }
  },

  render () {
    return (
      <div class='col-lg-4 col-sm-6 mb-4'>
        <div class={`card card-instance-details border-${this.status.level}`}>
          <div class='card-header'>
            <div class='d-flex'>
              <h5 class='card-title flex-grow-1 m-0'>
                <a href={this.instance.url} class={`text-${this.status.level}`}>
                  {this.instance.name}
                </a>
              </h5>
              <div class='dropdown'>
                <a
                  class='dropdown-toggle toggle-instance-actions'
                  id={`openode-instance-${this.instance.id}`}
                  data-toggle='dropdown'
                  aria-haspopup='true'
                  aria-expanded='false'
                >
                  <i class='fa fa-cog' />
                </a>
                <div
                  class='dropdown-menu dropdown-menu-right'
                  aria-labelledby={`openode-instance-${this.instance.id}`}
                >
                  <Deploy instance={this.instance} onUpdateStatus={this.updateStatus} onDisplayAlert={this.displayAlert} />
                  <Stop instance={this.instance} onUpdateStatus={this.updateStatus} onDisplayAlert={this.displayAlert} />
                  <div class='dropdown-divider' />
                  <Delete instance={this.instance} onUpdateStatus={this.updateStatus} onDisplayAlert={this.displayAlert} />
                </div>
              </div>
            </div>
          </div>
          <div class='card-body'>
            <p>
                Plan: <b>{this.instance.plan}</b>
            </p>
            <p>
                Status:
              <span class={`badge badge-${this.status.level}`}>
                <i class={`${this.status.icon ? this.status.icon : ''}`} /> {`${this.status.message}`}
              </span>
            </p>
            <p>Disk Usage: {this.instance.disk.usage} (From {this.instance.disk.total})</p>
            <p>Memory Usage: {this.instance.memory.total} (From {this.instance.memory.total})</p>
          </div>
          <div class='card-footer text-muted'>
            <div class='btn-group w-100' role='group' aria-label='Access Buttons'>
              <a href={`/admin/instances/${this.instance.id}/edit`} class='btn btn-sm btn-outline-secondary'>
                <i class='fa fa-edit' /> Settings
              </a>
              <a href={`/admin/instances/${this.instance.id}/collaborators`} class='btn btn-sm btn-outline-secondary position-relative'>
                <i class='fa fa-user' /> Collaborators
                <span class='badge badge-info badge-counter'>
                  {this.instance.collaborators}
                </span>
              </a>
              <a href={`/admin/instances/${this.instance.id}/access`} class='btn btn-sm btn-outline-secondary'>
                <i class='fa fa-terminal' /> Access
              </a>
              <a href={`/admin/instances/${this.instance.id}/credits`} class='btn btn-sm btn-outline-secondary position-relative'>
                <i class='fa fa-coins' /> Credits
                <span class='badge badge-info badge-counter'>
                  {this.instance.credits}
                </span>
              </a>
            </div>
          </div>
        </div>
      </div>
    )
  }
}