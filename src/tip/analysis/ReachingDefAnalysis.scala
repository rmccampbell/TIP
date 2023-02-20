package tip.analysis

import tip.ast.AstNodeData.DeclarationData
import tip.ast.AstOps._
import tip.ast._
import tip.cfg.CfgOps._
import tip.cfg._
import tip.lattices._
import tip.solvers._

/**
  * Base class for the reaching analysis
  */
abstract class ReachingDefAnalysis(cfg: IntraproceduralProgramCfg)(implicit declData: DeclarationData) extends FlowSensitiveAnalysis[CfgNode](cfg) {

  import AstNodeData._

  val allAssigns: Set[AAssignStmt] = cfg.nodes.flatMap(_.appearingAssignments)

  val lattice = new MapLattice(cfg.nodes, new PowersetLattice[AAssignStmt](allAssigns))

  def transfer(n: CfgNode, s: lattice.sublattice.Element): lattice.sublattice.Element =
    n match {
      case r: CfgStmtNode =>
        r.data match {
          case ass: AAssignStmt =>
            ass.left match {
              case id: AIdentifier => s.filterNot(_.left == id) + ass
              case _ => s
            }
          case _ => s
        }
      case _ => s
    }
}

/**
  * Reaching analysis that uses the simple fixpoint solver.
  */
class ReachingDefAnalysisSimpleSolver(cfg: IntraproceduralProgramCfg)(implicit declData: DeclarationData)
    extends ReachingDefAnalysis(cfg)
    with SimpleMapLatticeFixpointSolver[CfgNode]
    with ForwardDependencies

/**
  * Reaching variables analysis that uses the worklist solver.
  */
class ReachingDefAnalysisWorklistSolver(cfg: IntraproceduralProgramCfg)(implicit declData: DeclarationData)
    extends ReachingDefAnalysis(cfg)
    with SimpleWorklistFixpointSolver[CfgNode]
    with ForwardDependencies
