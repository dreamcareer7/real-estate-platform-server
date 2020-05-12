const BrandAsset = require('../../models/Brand/asset')
const { expect } = require('../../utils/validator')

const createAsset = async (req, res) => {
  const asset = await BrandAsset.createFromRequest(req.params.id, req)
  res.model(asset)
}

const getAssets = async (req, res) => {
  const assets = await BrandAsset.getByBrand(req.params.id)
  res.collection(assets)
}

const deleteAsset = async (req, res) => {
  const asset = await BrandAsset.get(req.params.asset)

  expect(asset.brand).to.equal(req.params.id)

  await BrandAsset.delete(asset.id)

  res.status(204)
  res.end()
}

const router = function ({app, b, access, am}) {
  app.post('/brands/:id/assets', b, access, am(createAsset))
  app.get('/brands/:id/assets', b, access, am(getAssets))
  app.delete('/brands/:id/assets/:asset', b, access, am(deleteAsset))
}

module.exports = router
