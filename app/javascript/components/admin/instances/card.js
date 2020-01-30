import Deploy from './actions/deploy';
import Restart from './actions/restart';
import Stop from './actions/stop';
import Delete from './actions/delete';
import axios from 'axios';

export default {
  name: 'InstanceCard',

  props: {
      instance: Object
  },

  methods: {
    updateStatus(data){
      this.status = data.status;
      this.processing = data.processing;
    }
  },

  data() {
    return { 
      status: this.instance.status,
      processing: false
    }
  },  

  render() {
      return(
        <div class="col-lg-4 col-sm-6 mb-4">
          <div class="card card-instance-details">
            <div class="card-header">
              <div class="d-flex">
                <h5 class="card-title flex-grow-1 m-0">
                  <a href={this.instance.url}>
                    { this.instance.name }
                  </a>              
                </h5>
                <div class="dropdown">
                  <a class="dropdown-toggle"
                    type="button"
                    id={`openode-instance-${this.instance.id}`}
                    data-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false">
                    <i class="fa fa-cog"></i>
                  </a>
                  <div class="dropdown-menu dropdown-menu-right"
                       aria-labelledby={`openode-instance-${this.instance.id}`}>
                       <Deploy instance={this.instance} onUpdateStatus={this.updateStatus}/>
                       <Restart instance={this.instance} onUpdateStatus={this.updateStatus}/>
                       <Stop instance={this.instance} onUpdateStatus={this.updateStatus}/>
                       <div class="dropdown-divider"></div>
                       <a class="dropdown-item" href={`/admin/instances/${this.instance.id}/scheduler`}>Scheduler</a>
                       <a class="dropdown-item" href={`/docs`}>Docs</a>
                       <div class="dropdown-divider"></div>
                       <Delete instance={this.instance} onUpdateStatus={this.updateStatus}/>
                  </div>
                </div>                  
              </div>
            </div>            
            <div class="card-body">
              <p>
                Plan: <b>{this.instance.plan}</b>
              </p>
              <p>
                Status: 
                <span class={`badge badge-${this.status.level}`}>
                  <i class={`${this.status.icon}`}></i> {`${this.status.message}`}
                </span>
              </p>
              <p>Disk Usage: {this.instance.disk.usage} (From {this.instance.disk.total})</p>
              <p>Memory Usage: {this.instance.memory.total} (From {this.instance.memory.total})</p>
            </div>
            <div class="card-footer text-muted">
              <div class="btn-group w-100" role="group" aria-label="Access Buttons">
                <a href={`/admin/instances/${this.instance.id}/edit`} class="btn btn-sm btn-outline-secondary">
                  <i class="fa fa-edit"></i> Settings
                </a>                 
                <a href={`/admin/instances/${this.instance.id}/collaborators`} class="btn btn-sm btn-outline-secondary position-relative">
                  <i class="fa fa-user"></i> Collaborators
                  <span class="badge badge-info badge-counter">
                    {this.instance.collaborators}
                  </span>
                </a> 
                <a href={`/admin/instances/${this.instance.id}/access`} class="btn btn-sm btn-outline-secondary">
                  <i class="fa fa-terminal"></i> Access
                </a>
                <a href={`/admin/instances/${this.instance.id}/credits`} class="btn btn-sm btn-outline-secondary position-relative">
                  <i class="fa fa-coins"></i> Credits
                  <span class="badge badge-info badge-counter">
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