import axios from 'axios'

export default {
  name: 'New',

  data: function () {
    return {
      modalShow: false,
      form: {
        domain_type: null,
        site_name: '',
        plan: null,
        location: null,
        domain: ''
      },
      plans: [
        { value: null, text: 'Select One' },
        { value: 1, text: 'Sandbox' },
        { value: 2, text: '500MB' }
      ],
      locations: [
        { text: 'Select One', value: null },
        'Montreal (Canada)',
        'Roubaix (France)',
        'Kansas City (USA)'
      ],
      domains: [
        { text: 'Select One', value: null },
        'openode',
        'custom'],
      show: {
        form: true,
        custom_domain: false
      }
    }
  },

  methods: {
    showModal () {
      this.$refs.newInstanceModal.show()
    },

    onSubmit () {
      alert(JSON.stringify(this.form))
    },

    onReset () {
      this.form.plan = null
      this.form.location = null
      this.form.domain_type = null
      this.form.site_name = ''
      this.form.domain = ''
      
      this.show.form = false
      this.show.custom_domain = false
    }
  },

  render () {
    let custom_domain_input = null

    if (this.form.domain_type == 'custom') {
      custom_domain_input = <div>
        <p class='alert alert-info'>
          Enter all aliases for one given custom domain, one per line. Example:
          <br /><br />
          mydomain.com<br />
          www.mydomain.com<br />
          blog.mydomain.com
        </p>
        <b-form-group id='input-group-2' label='Custom Domain:' label-for='input-2'>
          <b-form-textarea
            id='input-2'
            v-model={this.form.domain}
            placeholder='Your Domain'
          />
        </b-form-group>
      </div>
    }

    return (
      <div>
        <b-btn on-click={this.showModal} variant='outline-dark' size='sm'>
          <i class='fa fa-plus' /> Add New
        </b-btn>
        <b-modal ref='newInstanceModal' hide-footer title='Add New Instance'>
          <div>
            <b-form on-submit:prevent={this.onSubmit} on-reset:prevent={this.onReset}>
              <b-form-group id='input-group-1' label='Domain:' label-for='input-1'>
                <b-form-select
                  id='input-1'
                  v-model={this.form.domain_type}
                  options={this.domains}
                  required
                />
              </b-form-group>

              {custom_domain_input}

              <b-form-group id='input-group-3' label='Site Name:' label-for='input-3'>
                <b-form-input
                  id='input-3'
                  v-model={this.form.name}
                  required
                  placeholder='Enter Site name'
                />
              </b-form-group>

              <b-form-group id='input-group-4' label='Location:' label-for='input-4'>
                <b-form-select
                  id='input-4'
                  v-model={this.form.location}
                  options={this.locations}
                  required
                />
              </b-form-group>

              <b-form-group id='input-group-5' label='Plan:' label-for='input-5'>
                <b-form-select
                  id='input-5'
                  v-model={this.form.plan}
                  options={this.plans}
                  required
                />
              </b-form-group>

              <b-button type='submit' variant='success' block>Create</b-button>
            </b-form>
          </div>
        </b-modal>
      </div>
    )
  }
}
