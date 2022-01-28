# GitHub Actions Wrapper for flyctl with Output

This GitHub Action is a Wrapper for the [flyctl](https://github.com/superfly/flyctl) Command Line Tool, similar to [flyctl-actions](https://github.com/superfly/flyctl-actions) with the crucial difference that this Action provides a output using `${{steps.ID.outputs.stdout}}`.

This repository has been mainly used to learn about the creation of custom GitHub Actions. Any adivce is appreciated.

## Usage

```yaml
name: Deploy to Fly
on: [push]
jobs:
  deploy:
    name: Deploy proxy
    runs-on: ubuntu-latest
    steps:
      # This step checks out a copy of your repository.
      - uses: actions/checkout@v2
      # This step runs `flyctl deploy` and saves the output in `${{steps.ID.flyctl_out.stdout}}`.
      - uses: JabobKrauskopf/flyctl-actions-with-output@main
        id: flyctl_out
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
        with:
          args: "postgres create --region fra --vm-size shared-cpu-1x --initial-cluster-size 1 --volume-size 1"
      - name: Echo Output of previouse step
        run: echo ${{steps.flyctl_out.outputs.stdout}}
```

See the [flyctl documentation](https://fly.io/docs/flyctl/) for more information on `flyctl`

## Credit

Credit goes to [flyctl-actions](https://github.com/superfly/flyctl-actions)
